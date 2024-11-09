const express = require('express');
const cors = require('cors');
const admin = require('firebase-admin');
const serviceAccount = require('./config/music-app-9c9ec-firebase-adminsdk-dxtbh-bb52018e0a.json'); 

// Initialize Firebase Admin
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  storageBucket: 'music-app-9c9ec.appspot.com' // Make sure the storage bucket name matches
});

const db = admin.firestore();
const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Get all songs
app.get('/songs', async (req, res) => {
  try {
    const songsSnapshot = await db.collection('songs').get();
    const songs = songsSnapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
    res.status(200).json(songs);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get playlists for a user
app.get('/user/playlists', async (req, res) => {
  const { userId } = req.query; // Fetch userId from query params
  if (!userId) {
    return res.status(400).json({ error: 'User ID is required' });
  }

  try {
    const playlistsSnapshot = await db.collection('users').doc(userId).collection('playlists').get();
    const playlists = playlistsSnapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
    res.status(200).json(playlists);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Create a new playlist
app.post('/user/playlists', async (req, res) => {
  const { userId, name, songs } = req.body;

  if (!userId || !name || !Array.isArray(songs)) {
    return res.status(400).json({ error: 'Missing required fields' });
  }

  try {
    await db.collection('users').doc(userId).collection('playlists').add({
      name,
      songs
    });
    res.status(201).send('Playlist created');
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Delete a playlist
app.delete('/user/playlists/:playlistId', async (req, res) => {
  const { playlistId } = req.params;
  try {
    const playlistRef = db.collection('users').doc(req.query.userId).collection('playlists').doc(playlistId);
    await playlistRef.delete();
    res.status(200).send('Playlist deleted');
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
