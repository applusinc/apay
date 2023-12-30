const express = require('express');
const authRouter = require('./routes/auth');
const connection = require("./database/database");
const app = express();
const PORT = 3000;
app.use(express.json());
app.use(authRouter);


app.listen(PORT, ()  => {
    console.log('Listening on port ' + PORT);
});