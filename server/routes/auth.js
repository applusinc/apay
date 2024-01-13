// auth.js
const express = require('express');
const { connection } = require("../database/database");
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const auth = require("../middlewares/auth");
const moment = require('moment'); 

const authRouter = express.Router();

authRouter.post("/api/signup", async (req, res) => {
    try {
        const {id, name, surname, email, hashedPassword, phone, tckn, birthday, serial, validUntil} = req.body;

        if (!id || !name || !surname || !email || !hashedPassword || !phone || !tckn || !birthday || !serial || !validUntil) {
            return res.status(400).json({ "error": "Gönderilen veriler eksik veya yanlış." });
        }
        console.log(id);

        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            return res.status(400).json({ "error": "E-mail yanlış formatta." });
        }

        if(hashedPassword.length != 6){
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

        
        const hashedPassword2 = await bcrypt.hash(hashedPassword, 8);
       
        const insertUserQuery = 'INSERT INTO user (id, name, surname, email, password, phone, tckn, birthday, serial, validuntil, type) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';
        const [result] = await connection.query(insertUserQuery, [id, name, surname, email, hashedPassword2, phone, tckn, birthday, serial, validUntil, "2"]);
       
        
        const selectUserQuery = 'SELECT * FROM user WHERE id = ?'; 
        const [userResult] = await connection.query(selectUserQuery, [id]);

       
         res.status(200).json({user: userResult [0]});
        
    } catch (error) {
        res.status(500).json({ "error": error.message });
    }
});






authRouter.post("/api/signin", async (req, res) => {
    try {
        const { phone, hashedPassword } = req.body;
  
if (!hashedPassword || !phone) {
    return res.status(400).json({ "error": "Gönderilen veriler eksik veya yanlış." });
}

if (hashedPassword.length !== 6) {
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

const isMatch = await bcrypt.compare(hashedPassword, phoneCheckResult[0].password);

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
const loginTime = moment();
const userQuery = "SELECT * FROM user WHERE phone = ?";
const [userCheckResult] = await connection.query(userQuery, [phone]);
const token = jwt.sign({id: userCheckResult[0].id, phone: userCheckResult[0].phone, password: hashedPassword, time: loginTime}, "passwordKey");
const passTryQuery = 'UPDATE user SET passwordtry = ? WHERE phone = ?';
await connection.query(passTryQuery, [0, phone]);
res.status(200).json({user: userCheckResult[0], token: token});
    
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
        res.status(400).json(false);
    }
});


authRouter.post("/api/checkphone", async (req, res) => {
    try {
        const {phone} = req.body;

if (!phone) {
    return res.status(400).json({ "error": "Gönderilen veriler eksik veya yanlış." });
}



if (phone.length !== 12) {
    return res.status(400).json({ "error": "Telefon numarası yanlış formatta." });
}

// Telefon (phone) kontrolü
const phoneCheckQuery = 'SELECT password FROM user WHERE phone = ?';
const [phoneCheckResult] = await connection.query(phoneCheckQuery, [phone]);

if (phoneCheckResult.length === 0) {
    return res.status(200).json({ "result": "false" });
}

return res.status(200).json({ "result": "true" });


    } catch (error) {
        res.status(500).json({ "error": error.message });
    }
});


authRouter.post("/api/checktckn", async (req, res) => {
    try {
        const {tckn} = req.body;

if (!tckn) {
    return res.status(400).json({ "error": "Gönderilen veriler eksik veya yanlış." });
}



if (tckn.length !== 11) {
    return res.status(400).json({ "error": "Gönderilen veriler eksik veya yanlış." });
}

// Telefon (phone) kontrolü
const tcknCheckQuery = 'SELECT passwordtry FROM user WHERE tckn = ?';
const [tcknCheckResult] = await connection.query(tcknCheckQuery, [tckn]);

if (tcknCheckResult.length === 0) {
    return res.status(200).json({ "result": "false" });
}

return res.status(200).json({ "result": "true" });


    } catch (error) {
        res.status(500).json({ "error": error.message });
    }
});


authRouter.post("/api/checkphone", async (req, res) => {
    try {
        const {phone} = req.body;

if (!phone) {
    return res.status(400).json({ "error": "Gönderilen veriler eksik veya yanlış." });
}



if (phone.length !== 12) {
    return res.status(400).json({ "error": "Telefon numarası yanlış formatta." });
}

// Telefon (phone) kontrolü
const phoneCheckQuery = 'SELECT password FROM user WHERE phone = ?';
const [phoneCheckResult] = await connection.query(phoneCheckQuery, [phone]);

if (phoneCheckResult.length === 0) {
    return res.status(200).json({ "result": "false" });
}

return res.status(200).json({ "result": "true" });


    } catch (error) {
        res.status(500).json({ "error": error.message });
    }
});


authRouter.post("/api/checkemail", async (req, res) => {
    try {
        const {email} = req.body;

        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            return res.status(400).json({ "error": "E-mail yanlış formatta." });
        }





// email kontrolü
const emailCheckQuery = 'SELECT passwordtry FROM user WHERE email = ?';
const [emailCheckResult] = await connection.query(emailCheckQuery, [email]);

if (emailCheckResult.length === 0) {
    return res.status(200).json({ "result": "false" });
}

return res.status(200).json({ "result": "true" });


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

 



module.exports = authRouter;
