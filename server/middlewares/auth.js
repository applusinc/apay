const jwt = require('jsonwebtoken');
const { connection } = require("../database/database");
const bcrypt = require('bcrypt');
const moment = require('moment'); 

const auth = async (req, res, next) => {
try{
const token = req.header("x-auth-token");
if(!token) res.status(401).json({error: "Auth token bulunamadı, erişim reddedildi.0"})
const verified = jwt.verify(token, "passwordKey");
    if(!verified) return res.status(401).json({error: "Auth token doğrulaması başarısız, erişim reddedildi.1"});
    const phoneCheckQuery = 'SELECT password, passwordtry FROM user WHERE phone = ?';
const [phoneCheckResult] = await connection.query(phoneCheckQuery, [verified.phone]);

if (phoneCheckResult.length === 0) {
    return res.status(401).json({ "error": "Auth token doğrulaması başarısız, erişim reddedildi.2" });
}

if (phoneCheckResult[0].passwordtry >= 3) {
    return res.status(401).json({ "error": "Auth token doğrulaması başarısız, erişim reddedildi.3" });
}
const isMatch = await bcrypt.compare(verified.password, phoneCheckResult[0].password);

if (!isMatch) {
    const passTryQuery = 'UPDATE user SET passwordtry = ? WHERE phone = ?';
    await connection.query(passTryQuery, [phoneCheckResult[0].passwordtry + 1, phone]);
    return res.status(401).json({ "error": "Auth token doğrulaması başarısız, erişim reddedildi.4" });
}
const currentTime = moment();
const loginTime = moment(verified.time);
const diffInMinutes = currentTime.diff(loginTime, 'minutes');
if (diffInMinutes > 1) {
    return res.status(408).json({ message: 'Doğrulama başarısız, oturum süresi dolmuş' });
  }
    req.id = verified.id;
    req.phone= verified.phone;
    req.password = verified.password;
    req.token = token;
    next();
}catch (err){
    console.log(err);
    res.status(500).json({error: err.message});
}
}
 
module.exports = auth; 