# app.py
from flask import Flask, jsonify, request
import requests

app = Flask(__name__)

MAGIC_HEADER_URL = "https://magic-server-802314573716.europe-north1.run.app/magic-code"
FINAL_ANSWER_URL = "https://final-answer-802314573716.europe-north1.run.app/final-answer"

@app.route('/magic-header', methods=['GET'])
def get_magic_header():
    try:
        # Call the external API to get the header value
        response = requests.get(MAGIC_HEADER_URL)
        response.raise_for_status()
        
        # Extract the required header value from the response
        data = response.json()
        magic_header = data.get("useThisHeaderToAuthenticateTowardsTheFinalEndpoint")
        
        if magic_header is None:
            return jsonify({"error": "Required header not found"}), 500
        
        return jsonify({"magicHeader": magic_header})
    
    except requests.exceptions.RequestException as e:
        return jsonify({"error": str(e)}), 500

@app.route('/final-answer', methods=['GET'])
def get_final_answer():
    # First, call /magic-header to get the authentication token
    magic_header_response = requests.get(request.host_url + "magic-header")
    if magic_header_response.status_code != 200:
        return jsonify({"error": "Failed to retrieve magic header"}), 500
    
    magic_header_data = magic_header_response.json()
    token = magic_header_data.get("magicHeader")
    
    if token is None:
        return jsonify({"error": "Token not found"}), 500
    
    # Call the final answer API using the token in the Authorization header
    headers = {"Authorization": f"Bearer {token}"}
    try:
        final_answer_response = requests.get(FINAL_ANSWER_URL, headers=headers)
        final_answer_response.raise_for_status()
        
        # Extract the final answer from the response
        data = final_answer_response.json()
        final_answer = data.get("finalAnswer")
        
        if final_answer is None:
            return jsonify({"error": "Final answer not found"}), 500
        
        return jsonify({"finalAnswer": final_answer})
    
    except requests.exceptions.RequestException as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
