const express = require('express');
const app = express();
const PORT = 3000;

app.get('/', (req, res) => {
    res.send('Hello World! The time says ' + new Date().toString());
});

app.listen(PORT, () => {
    console.log(`Example App listening on port ${PORT}`);
});
