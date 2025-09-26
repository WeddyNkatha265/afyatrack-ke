const express = require('express');
const bodyParser = require('body-parser');
const { Pool } = require('pg');
const path = require('path');

const app = express();
const port = process.env.PORT || 3000;

// Database configuration
const pool = new Pool({
    user: process.env.DB_USER || 'postgres',
    host: process.env.DB_HOST || 'localhost',
    database: process.env.DB_NAME || 'hospitals',
    password: process.env.DB_PASSWORD || 'password',
    port: process.env.DB_PORT || 5432,
});

// Middleware
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static('public'));

// Initialize database
async function initDB() {
    try {
        await pool.query(`
            CREATE TABLE IF NOT EXISTS hospitals (
                id SERIAL PRIMARY KEY,
                name VARCHAR(255) NOT NULL,
                county VARCHAR(100) NOT NULL,
                facility_type VARCHAR(100) NOT NULL,
                beds INTEGER,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        `);
        
        // Insert sample data if table is empty
        const result = await pool.query('SELECT COUNT(*) FROM hospitals');
        if (parseInt(result.rows[0].count) === 0) {
            await pool.query(`
                INSERT INTO hospitals (name, county, facility_type, beds) VALUES
                ('Kenyatta National Hospital', 'Nairobi', 'Public', 1800),
                ('Moi Teaching and Referral Hospital', 'Uasin Gishu', 'Public', 800),
                ('Coast General Hospital', 'Mombasa', 'Public', 600)
            `);
            console.log('Sample data inserted');
        }
        
        console.log('Database initialized successfully');
    } catch (err) {
        console.error('Database initialization error:', err);
    }
}

// Routes
app.get('/', async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM hospitals ORDER BY created_at DESC');
        res.render('index', { hospitals: result.rows });
    } catch (err) {
        console.error('Error fetching hospitals:', err);
        res.status(500).send('Error fetching hospitals');
    }
});

app.post('/hospitals', async (req, res) => {
    const { name, county, facility_type, beds } = req.body;
    try {
        await pool.query(
            'INSERT INTO hospitals (name, county, facility_type, beds) VALUES ($1, $2, $3, $4)',
            [name, county, facility_type, beds || null]
        );
        res.redirect('/');
    } catch (err) {
        console.error('Error adding hospital:', err);
        res.status(500).send('Error adding hospital');
    }
});

// Health check endpoint
app.get('/health', (req, res) => {
    res.status(200).json({ status: 'OK', timestamp: new Date().toISOString() });
});

// Start server
app.listen(port, async () => {
    console.log(`🚀 AfyaTrack KE server starting on port ${port}...`);
    await initDB();
    console.log(`✅ AfyaTrack KE server running on http://localhost:${port}`);
    console.log(`🏥 Health check available at http://localhost:${port}/health`);
});

// Handle graceful shutdown
process.on('SIGINT', async () => {
    console.log('\n🛑 Shutting down server gracefully...');
    await pool.end();
    process.exit(0);
});