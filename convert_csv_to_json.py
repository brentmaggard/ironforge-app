#!/usr/bin/env python3
"""
Convert CSV files to JSON for better handling of complex data structures.
This handles multiline content and JSON arrays that are difficult to parse with simple CSV parsers.
"""

import csv
import json
import os
from pathlib import Path

def convert_csv_to_json(csv_file_path, json_file_path):
    """Convert a CSV file to JSON format."""
    data = []
    
    try:
        with open(csv_file_path, 'r', newline='', encoding='utf-8') as csvfile:
            # Use DictReader to automatically handle headers
            reader = csv.DictReader(csvfile)
            
            for row in reader:
                # Convert string representations of JSON arrays to actual lists
                for key, value in row.items():
                    if value and value.startswith('[') and value.endswith(']'):
                        try:
                            row[key] = json.loads(value)
                        except json.JSONDecodeError:
                            # Keep as string if not valid JSON
                            pass
                    elif value and value.lower() in ['true', 'false']:
                        row[key] = value.lower() == 'true'
                    elif value and value.replace('.', '').replace('-', '').isdigit():
                        # Convert numeric strings to numbers
                        if '.' in value:
                            row[key] = float(value)
                        else:
                            row[key] = int(value)
                
                data.append(row)
        
        # Write to JSON file
        with open(json_file_path, 'w', encoding='utf-8') as jsonfile:
            json.dump(data, jsonfile, indent=2, ensure_ascii=False)
        
        print(f"✅ Converted {csv_file_path} to {json_file_path} ({len(data)} records)")
        
    except Exception as e:
        print(f"❌ Error converting {csv_file_path}: {e}")

def main():
    """Convert all CSV files in data bk folder to JSON."""
    data_dir = Path("data bk")
    
    if not data_dir.exists():
        print("❌ 'data bk' directory not found!")
        return
    
    # Create assets/data directory for JSON files
    assets_dir = Path("assets/data")
    assets_dir.mkdir(parents=True, exist_ok=True)
    
    csv_files = [
        "exercises_rows.csv",
        "goals_rows.csv", 
        "exercise_categories_rows.csv",
        "exercise_equipment_rows.csv",
        "goal_progress_rows.csv"
    ]
    
    for csv_file in csv_files:
        csv_path = data_dir / csv_file
        json_file = csv_file.replace('.csv', '.json')
        json_path = assets_dir / json_file
        
        if csv_path.exists():
            convert_csv_to_json(csv_path, json_path)
        else:
            print(f"⚠️  CSV file not found: {csv_path}")

if __name__ == "__main__":
    main()