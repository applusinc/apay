const express = require('express');
const authRouter = require('./routes/auth');
const userRouter = require("./routes/user");
const connection = require("./database/database");
const app = express();
const PORT = 3000;
app.use(express.json());
app.use(authRouter);
app.use(userRouter);


app.listen(PORT, ()  => {
    console.log('Listening on port ' + PORT);
});