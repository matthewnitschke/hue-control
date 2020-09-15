const path = require('path')

const port = 3000;
const express = require('express');
const app = express();
const http = require('http').createServer(app);
const io = require('socket.io')(http);

app.use(express.static('web'))

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname + '/web/index.html'));
})

io.on('connection', (socket) => {
  console.log('a user connected');
});

http.listen(port, () =>
  console.log(`Example app listening at http://localhost:${port}`)
);