const jwt = require('jsonwebtoken');

const auth = async (req, res, next) => {
try{
const token = req.header("x-auth-token");
if(!token) res.status(401).json({error: "Auth token bulunamadı, erişim reddedildi."})
const verified = jwt.verify(token, "passwordKey");
    if(!verified) return res.status(401).json({error: "Auth token doğrulaması başarısız, erişim reddedildi."});

    req.user = verified.indexOf;
    req.token = token;
    next();
}catch (err){
    res.status(500).json({error: err.message});
}
}
 
module.exports = auth;