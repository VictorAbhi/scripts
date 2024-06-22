import requests
from bs4 import BeautifulSoup
import time
import argparse

# Function to fetch Google search results
def fetch_google_results(query):
    headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
    }
    response = requests.get(f"https://www.google.com/search?q={query}", headers=headers)
    return response.text

# Function to parse Google search results
def parse_results(html):
    soup = BeautifulSoup(html, 'html.parser')
    results = []
    for g in soup.find_all(class_='g'):
        title = g.find('h3')
        link = g.find('a')['href']
        if title and link:
            results.append({
                'title': title.text,
                'link': link
            })
    return results

# Main function to read dorks from file, add 'site:' attribute, and fetch results
def main(dorks_file, site):
    with open(dorks_file, 'r') as file:
        dorks = file.readlines()

    for dork in dorks:
        dork = dork.strip()
        query = f"{dork} site:{site}"
        print(f"Fetching results for: {query}")
        
        html = fetch_google_results(query)
        results = parse_results(html)
        
        if results:
            print("Results found:")
            for result in results:
                print(f"Title: {result['title']}")
                print(f"Link: {result['link']}")
        else:
            print("No results found.")
        
        # Sleep to avoid getting blocked by Google
        time.sleep(2)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Fetch Google search results for dorks with a specified site.")
    parser.add_argument("dorks_file", type=str, help="Path to the file containing Google Dorks")
    parser.add_argument("site", type=str, help="The site to search within")
    
    args = parser.parse_args()
    
    main(args.dorks_file, args.site)
