const path = require('path')
const fs = require('fs');

const v3 = require('node-hue-api').v3
  , discovery = v3.discovery
  , hueApi = v3.api
  , GroupLightState = v3.model.lightStates.GroupLightState;

const port = 3000;
const express = require('express');
const app = express();
const http = require('http').createServer(app);
const io = require('socket.io')(http);

const { hueUsername, hueDeviceName } = require('./environment.js');

app.use(express.static('web'))

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname + '/web/index.html'));
})

app.get('/set/:value', async (req, res) => {

  const { value } = req.params;

  const groupState = new GroupLightState()
    .on()
    .brightness(value);

  hueApi.groups.setGroupState(groupId, groupState);
});

app.get('/groups', async (req, res) => {
  const api = await hueApi.createLocal(bridgeIp).connect();
  let allGroups = await api.groups.getAll()

    // .then(allGroups => {
    //   // Display the groups from the bridge
    //   allGroups.forEach(group => {
    //     console.log(group.toStringDetailed());
    //   });
    // });
});

app.get('/auth', async (req, res) => {
  const discoveryResults = await discovery.nupnpSearch();

  if (discoveryResults.length === 0) {
    res.status(400).send({
      message: 'Failed to resolve any Hue Bridges'
    })
    return;
  }

  const bridgeIp = discoveryResults[0].ipaddress;
  
  const unauthenticatedApi = await hueApi.createLocal(bridgeIp).connect();

  try {
    let createdUser = await unauthenticatedApi.users.createUser(hueUsername, hueDeviceName);
    console.log(`Hue Bridge User: ${createdUser.username}`);
    console.log(`Hue Bridge User Client Key: ${createdUser.clientkey}`);

    fs.writeFile(path.join(__dirname, '../', 'save.json'), JSON.stringify({
      username: createdUser.username,
      clientKey: createdUser.clientKey
    }))

    res.status(200).send({
      message: 'Created and saved to save.json'
    })
  } catch(err) {
    console.error(err)
    if (err.getHueErrorType() === 101) {
      res.status(400).send({
        message: 'The Link button on the bridge was not pressed. Please press the Link button and try again.'
      })
    } else {
      res.status(400).send({
        message: `Unexpected Error: ${err.message}`
      })
    }
  }
});

io.on('connection', (socket) => {
  console.log('a user connected');
});

http.listen(port, () =>
  console.log(`Example app listening at http://localhost:${port}`)
);