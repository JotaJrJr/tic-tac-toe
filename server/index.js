const express = require('express');
const http = require('http');
const mongoose = require('mongoose');

require('dotenv').config();

const app = express();
const port = process.env.PORT | 3000;

const Room = require('./models/room_model');

var socketio = require('socket.io')(port);

app.use(express.json());

const database = process.env.DATABASE_URL;

socketio.on('connection', (socket) => {
    
    console.log('Connected!');
    
    socket.on('createRoom', async ({name}) => {
        
        console.log("ON CREATE ROOM", name);

        try {
            let room = new Room();
            let player = {
                socketId: socket.id,
                name: name,
                playerType: 'X',
            };
            room.players.push(player);
            room.turn = player;
            room = await room.save();
            console.log(room);
            const roomId = room._id.toString(); 
            console.log(roomId);
    
            socket.join(roomId);

            socketio.to(roomId).emit("roomCreated", room);

             
        } catch (error) {
            console.log(error);   
        }
    });

    socket.on('joinRoom', async ({name, roomId}) => {
        try {

            if (!roomId.match(/^[0-9a-fA-F]{24}$/)) {
                socket.emit('errorOccured', 'Please enter a valid room ID');
                return;
            }

            let room = await Room.findById(roomId);

            if (room.canJoin) {
                let player = {
                    name,
                    socketId: socket.id,
                    playerType: 'O',
                }
                socket.join(roomId);
                room.players.push(player);
                room.canJoin = false;
                room = await room.save();
                socketio.to(roomId).emit('roomJoined', room);
                socketio.to(roomId).emit('updatePlayers', room.players);
                socketio.to(roomId).emit('updateRoom', room);
            } else {
                socket.emit('errorOccured', 'Room is full');
                return;
            }
            
            if (!room) {
                socket.emit('errorOccured', 'Room not found');
                return;
            }

        } catch (e) {
            console.log(e);
        }
    });
});

mongoose.connect(database).then(() => {
    console.log('Connected to database successfully');
    
}).catch((err) => {
    console.log('Error connecting to database', err);
});

// server.listen(port, () => {
//     console.log(`Server listening on port: ${port}`);
// });

// socketio.on('createRoom', name => {
//     console.log(name);
// })