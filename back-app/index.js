require('dotenv').config();
const express = require('express');
const app = express();
const PORT = process.env.PORT || 4000;

app.get('/', (req, res) => {
    res.json({ message: 'Hello from Express!' });
});

app.get('/status', (req, res) => {
    const status = {
        status: 'OK',
        uptime: process.uptime(),
        timestamp: new Date().toISOString()
    };
    res.json(status);
});

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
