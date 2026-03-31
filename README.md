# Sports Venue Directory: Vietnam Market

## Project Overview
This project involves the design of a database schema and the implementation of an end-to-end data ingestion pipeline for a sports venue directory, specifically optimized for the Vietnamese sports community.

---

## 🏗️ Part 1: Database Schema Design

The database schema is engineered for high performance during rush hours and tailored to the specific data realities of the Vietnamese market.

### Key Design Decisions
* **Character Encoding:** Utilized `NVARCHAR` data types across text fields. This is a simple and efficient way to ensure complete UTF-8 compliance, preventing any data corruption of Vietnamese diacritics and tone marks.
* **Occupancy Separation:** Abstracted `Court_occupancy` into a separate, dedicated table. This relational design allows the schema to handle peak-hour booking traffic smoothly without causing database bottlenecks.
* **Currency Optimization:** Storing the Vietnamese Dong (VND) requires large whole numbers. Therefore, standard integers (`INT`) were chosen over `DECIMAL(10,2)`. Decimals accommodate global fractional cents but are functionally obsolete for VND, making integers a much more practical and space-efficient choice.

### Engineering Tradeoffs
* **Address Hierarchy vs. Simplicity:** The current address structure favors global simplicity over Vietnam's strict administrative hierarchy. I opted for a generalized address string rather than strictly normalizing locations into District, Ward, and Street tables, prioritizing rapid ingestion over granular geographic filtering.
* **Schedule Rigidity vs. Local Climate Reality:** The database currently enforces a strict single-shift schedule per day via a unique constraint to maintain robust data integrity. While this constraint simplifies the schema, it represents a tradeoff, as it fails to capture the reality of the local climate where many independent facilities close during the midday heat and reopen for evening sessions.

---

## 🕷️ Part 2: Data Ingestion Pipeline

To populate the directory, I engineered a custom ETL (Extract, Transform, Load) pipeline to scrape, clean, and format public venue data.

### Source Selection: Wikipedia
* **Accessibility:** Wikipedia is an open-source platform that does not block basic web scraping with aggressive anti-bot captchas.
* **Cost & Scalability:** Crawling public data was chosen over utilizing commercial APIs, as APIs impose strict rate limits on free tiers and charge exorbitant fees for bulk data access. 

### Methodology & Technical Skills Demonstrated
By building a custom web scraper from scratch, this pipeline demonstrates deep competency in:
* **ETL Pipeline Construction:** Moving data from raw HTML to a structured database format.
* **DOM Navigation:** Programmatically interacting with and parsing complex Document Object Models.
* **Data Sanitization:** Handling missing data gracefully and applying Regular Expressions (RegEx) to clean messy strings and strip citation artifacts.

### Data Limitations & Issues
* **Structural Inconsistency:** Because Wikipedia relies on decentralized volunteer editors, the infobox structures vary wildly. This results in frequent missing fields and messy, non-standard capacity formats (e.g., mixing text and numbers).
* **Sample Bias:** The data is heavily skewed toward massive, state-owned national stadiums. It largely misses the localized sports centers, futsal pitches, and independent facilities that everyday citizens actually book and use.
