## Project Overview
I am a Data Analyst, working at **Orion Strategy**, a market research and consulting firm specializing in providing data-driven insights for businesses and startups. Recently, a clothing startup approached us to conduct a **time series analysis** of men’s and women’s clothing sales in the U.S. market. Their goal is to gain a deep understanding of market trends, seasonality, and consumer behavior to make informed decisions regarding their market entry.

## Key Responsibilities

1. **ETL**: I set up an **ETL pipeline** using **Python** for data cleaning and loading, ensuring that the data was transformed into an analysis-ready format and stored in a **database**.
2. **Data Analysis**: I performed **time series analysis** using **SQL** to extract and analyze the data, and used **Excel** to create **visualizations** to help identify trends, seasonality, and consumer behavior.

## Data
- **Data Range**: January 1992 to January 2020.
- **Geography**: U.S. retail market for men’s and women’s clothing.

## Key Stakeholder Questions and Findings
##### **1. What are the sales trends over time for men's and women's clothing in the U.S.?**
- **Women's Clothing**: Historically dominated the market with a larger share, but its growth has slowed significantly over the years. From 1998–2008, it grew at an AAGR of 3.56%, but this dropped to 0.62% from 2009–2019. Women's sales saw a faster recovery after economic downturns but showed declining growth in after 2011.  
- **Men's Clothing**: While smaller in market share, it has shown stronger growth in recent years, with an AAGR of 2.68% from 2009–2019. It also recovered slower from recessions of 2008 but outpaced women's growth rates after 2011, signaling an upward trend in total sales.  

##### **2. Are there specific periods of growth or decline that can help predict future market behavior?**
- **Periods of Growth**:  
  - The industry rebounded strongly after the 2008 recession, with steady growth until 2011, particularly for men's clothing.  
  - 2017-2019 saw a steady comeback in YoY growth rates for both men's and women's clothing.  

- **Periods of Decline**:  
  - Economic downturns, such as the 2008 recession (-9.4% YoY in 2008) and the 2020 pandemic (-72.64% YoY), led to steep declines.  
  - Men's clothing typically faces sharper declines and slower recoveries than women's during such periods.

##### **3. What seasonal fluctuations are seen in clothing sales for both segments?**
- **Low Sales Periods**: January and February consistently have the lowest sales.  
- **Seasonal Peaks**:  
  - Spring (May): Peak sales due to seasonal change and new collection launches.  
  - Summer: June and July show declines, with a slight rebound in August (back-to-school shopping).  
  - Winter: The highest sales occur in the last quarter, driven by fall/winter collections and holiday shopping.  

Men’s and women’s clothing sales follow similar seasonal patterns, but segment-specific promotions or events may create slight variations.

##### **4. How do men’s and women’s clothing sales perform in comparison, and what are the implications for market entry?**
- Women's clothing has a historically larger market share (80:20 in the 1990s), though men's clothing has been catching up since 2011 with higher YoY growth rates.  
- Women’s sales recover faster after economic downturns, whereas men’s sales exhibit longer-term growth trends.  
- **Implications for Market Entry**:  
  - A balanced product portfolio targeting both segments could reduce risk.  
  - Focus on men’s clothing for steady long-term growth and women’s clothing for quicker recovery during economic shifts.  
  - Prioritize categories that align with current consumer preferences and target consumer demographic.

##### **5. What consumer behaviors or market conditions should the startup consider when planning their product offerings and pricing strategies?**
- **Price Sensitivity**: Clothing is price-elastic, making competitive pricing and promotional strategies critical during economic uncertainty.  
- **E-commerce Shift**: Invest in robust online channels to capitalize on the growing preference for digital shopping.   
- **Seasonal Adjustments**: Tailor product launches to seasonal peaks (e.g., back-to-school, holiday shopping).   

## Repository Structure
The repository is organized as follows:

```plaintext
├── data/
│   ├── raw_data/             # Contains the original raw dataset
│   ├── cleaned_data/         # Stores cleaned data ready for analysis
├── scripts/
│   ├── etl/                  # Python scripts for data cleaning and ETL pipeline
│   ├── analysis/             # SQL scripts for data analysis
├── visualizations/           # Output report with visualizations (charts, graphs) from analysis
├── docs/                     # Documentation files including business problem and project plan
│   ├── project_plan.md       # Initial project plan and scope
│   ├── business_problem.md   # Detailed business problem document
├── README.md                 # Project overview and repository guide
├── .gitignore                # Files and folders to be ignored by Git
└── LICENSE.md                # License information for the project
```
## Project Future Scope
1. Advanced machine learning techniques to forecast future sales trends.
2. Integration with external datasets (e.g., economic indicators) to enhance the analysis.


