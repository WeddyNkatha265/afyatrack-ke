-- Initialize hospitals database
CREATE TABLE IF NOT EXISTS hospitals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    county VARCHAR(100) NOT NULL,
    facility_type VARCHAR(100) NOT NULL,
    beds INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample Kenyan hospitals
INSERT INTO hospitals (name, county, facility_type, beds) VALUES
('Kenyatta National Hospital', 'Nairobi', 'Public', 1800),
('Moi Teaching and Referral Hospital', 'Uasin Gishu', 'Public', 800),
('Coast General Hospital', 'Mombasa', 'Public', 600),
('Nakuru Level 5 Hospital', 'Nakuru', 'Public', 500),
('Kisumu County Hospital', 'Kisumu', 'Public', 400),
('Aga Khan University Hospital', 'Nairobi', 'Private', 300),
('Nairobi Hospital', 'Nairobi', 'Private', 350),
('Mater Misericordiae Hospital', 'Nairobi', 'Private', 250)
ON CONFLICT DO NOTHING;