# Sports Venue Directory: Vietnam Market

## Part 1: Schema Design
**KEY FEATURES**: I design this schema to use within the Vietnamese sport community. Because Vietnamese characters are in UTF-8 format, I decided to use NVARCHAR as a simple and efficient way to avoid data corruption. By separating Court_occupancy records, the schema can handle rush hours smoothly without any bottlenecks. The separate amenities table handles generic values such as "giữ xe" and "Giữ xe ô tô" without needing constantly altering columns.
**TRADE OFF**: In the address structure, which currently favors global simplicity over Vietnam's strict administrative hierarchy, I decided to replace a more detailed address such as District, Ward, Street,... with a more general address. Another tradeoff involves currency formatting, as the DECIMAL(10,2) datatype accommodates global fractional cents but is functionally obsolete for the Vietnamese Dong. Storing VND requires large whole numbers, making standard integers a much more practical and space-efficient choice than decimals. Finally, the database currently enforces a strict single-shift schedule per day through a unique constraint to maintain data integrity. This constraint simplifies the schema but fails to capture the reality of the local climate, where many independent facilities close during the midday heat and reopen for evening sessions.

## Part 2: Data Ingestion
I considered wikipedia as a way to get data due to the fact that Wikipedia is an open-source platform that does not block basic web scraping with aggressive anti-bot captcha. By building a custom web scraper, I am able to prove I have a deep knowledge in processing and analyzing data and competent in the ETL pipeline, navigating DOM structures, handling missing data, and applying Regular Expressions to clean messy strings. Another reason for choosing crawling data over API is that API keys impose strict rate limits on free tiers, and charge for bulk data access. Some limitations of Wikipedia include a severe structural inconsistency; because Wikipedia relies on decentralized volunteer editors, infobox structures vary wildly, resulting in frequent missing fields and messy, non-standard capacity formats. Not only that, it heavily skewed toward massive, state-owned stadiums and misses local sport centers and independent facilities that everyday citizens actually book and use.

---
## OVERALL:
**TIME ESTIMATION:** 2 Mins
![Sports Venue Database Schema](Images/Database%20diagram.png)



## HOW TO INSTALL:
**TOOLS**: 
Python == 3.10.11 <br>
SQL Manager studio >= 18

**PACKAGE & DEPENDENCIES**:
<pre>
pip install -r requirements.txt
</pre>

## Project Structure
```text
Sport_Venue_directory/
├── Dataset/
│   └── vietnam_sports_venues.csv
├── Images/                  
│   └── Database diagram.png
├── SQL Schema/
│   └── Sport_venue_database.sql
├── LICENSE
├── Main.ipynb
├── README.md
└── requirements.txt
```
## 
