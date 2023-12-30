// auth.js
const express = require('express');
const { connection } = require("../database/database");
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const auth = require("../middlewares/auth");

const authRouter = express.Router();

authRouter.post("/api/signup", async (req, res) => {
    try {
        const { name, surname, email, password, phone, tckn, birthday } = req.body;

        if (!name || !surname || !email || !password || !phone || !tckn || !birthday) {
            return res.status(400).json({ "error": "Gönderilen veriler eksik veya yanlış." });
        }

        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            return res.status(400).json({ "error": "E-mail yanlış formatta." });
        }

        if(password.length != 6){
            return res.status(400).json({ "error": "Şifre 6 haneli olmalıdır." });
        }

        if(phone.length != 12){
            return res.status(400).json({ "error": "Telefon numarası yanlış formatta." });
        }
const tcRegex = /^[1-9][0-9]{9}[02468]$/;
        if(!tcRegex.test(tckn)){
            return res.status(400).json({ "error": "TCKN yanlış formatta." });
        }

    
        // E-posta (email) kontrolü
        const emailCheckQuery = 'SELECT * FROM user WHERE email = ?';
        const [emailCheckResult] = await connection.query(emailCheckQuery, [email]);

        if (emailCheckResult.length > 0) {
            return res.status(400).json({ "error": "Bu e-posta adresi zaten kullanılıyor." });
        }

        // Telefon (phone) kontrolü
        const phoneCheckQuery = 'SELECT * FROM user WHERE phone = ?';
        const [phoneCheckResult] = await connection.query(phoneCheckQuery, [phone]);

        if (phoneCheckResult.length > 0) {
            return res.status(400).json({ "error": "Bu telefon numarası zaten kullanılıyor." });
        }

        // TCKN kontrolü
        const tcknCheckQuery = 'SELECT * FROM user WHERE tckn = ?';
        const [tcknCheckResult] = await connection.query(tcknCheckQuery, [tckn]);

        if (tcknCheckResult.length > 0) {
            return res.status(400).json({ "error": "Bu TCKN zaten kullanılıyor." });
        }

        
        const hashedPassword = await bcrypt.hash(password, 8);
       
        const insertUserQuery = 'INSERT INTO user (name, surname, email, password, phone, tckn, birthday, type) VALUES (?, ?, ?, ?, ?, ?, ?, ?)';
        const [result] = await connection.query(insertUserQuery, [name, surname, email, hashedPassword, phone, tckn, birthday, "2"]);
       
        const userId = result.insertId;
        const selectUserQuery = 'SELECT * FROM user WHERE id = ?';
        const [userResult] = await connection.query(selectUserQuery, [userId]);

       
         res.status(200).json({user: userResult [0]});
        
    } catch (error) {
        res.status(500).json({ "error": error.message });
    }
});






authRouter.post("/api/signin", async (req, res) => {
    try {
        const { phone, password } = req.body;

if (!password || !phone) {
    return res.status(400).json({ "error": "Gönderilen veriler eksik veya yanlış." });
}

if (password.length !== 6) {
    return res.status(400).json({ "error": "Şifre 6 haneli olmalıdır." });
}

if (phone.length !== 12) {
    return res.status(400).json({ "error": "Telefon numarası yanlış formatta." });
}

// Telefon (phone) kontrolü
const phoneCheckQuery = 'SELECT password, passwordtry FROM user WHERE phone = ?';
const [phoneCheckResult] = await connection.query(phoneCheckQuery, [phone]);

if (phoneCheckResult.length === 0) {
    return res.status(400).json({ "error": "Bu telefon numarasına ait hesap bulunamıyor." });
}

if (phoneCheckResult[0].passwordtry >= 3) {
    return res.status(400).json({ "error": "Fazla sayıda şifre denediniz. Lütfen şifrenizi sıfırlayınız." });
}

const isMatch = await bcrypt.compare(password, phoneCheckResult[0].password);

if (!isMatch) {
    const passTryQuery = 'UPDATE user SET passwordtry = ? WHERE phone = ?';
    await connection.query(passTryQuery, [phoneCheckResult[0].passwordtry + 1, phone]);
    const remain = 2 - phoneCheckResult[0].passwordtry;
    var returnText = "";
    if(remain == 0){
         returnText = `Daha fazla şifre deneyemezsiniz.`
    }else {
         returnText = `${remain} hakkınız kaldı.`
    }
    
    return res.status(400).json({ "error": `Yanlış şifre. ${returnText}` });
}
const userQuery = "SELECT * FROM user WHERE phone = ?";
const [userCheckResult] = await connection.query(userQuery, [phone]);
const token = jwt.sign({id: userCheckResult[0].id}, "passwordKey");
userCheckResult[0].token = token;

res.status(200).json(userCheckResult[0]);
    
    } catch (error) {
        res.status(500).json({ "error": error.message });
    }
});


authRouter.post("/api/tokenisvalid", async (req, res) => {
    try {
        const token = req.header('x-auth-token');
if(!token) return res.json(false);
const verified = jwt.verify(token, "passwordKey");
    if(!verified) return res.json(false);

    const userQuery = "SELECT * FROM user WHERE id = ?";
    const [userCheckResult] = await connection.query(userQuery, [verified.id]);
if(userCheckResult == 0) return res.json(false);
res.json(true);

    } catch (error) {
        res.status(500).json(false);
    }
});


authRouter.get('/', auth, async (req, res) => {
    const userQuery = "SELECT * FROM user WHERE id = ?";
    const [userCheckResult] = await connection.query(userQuery, [req.user]);
    res.json({userCheckResult, token: req.token});
}); 



module.exports = authRouter;
