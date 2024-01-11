const mongoose = require('mongoose');

const playerSchema = new mongoose.Schema({
    name: {
        type: String,
        trim: true,
        required: true,
    },
    socketID: {
        type: String,
    },
    score: {
        required: true,
        type: Number,
        default: 0,
    },
    playerType: {
        required: true,
        type: String,  
    },
    
});

module.exports = playerSchema;