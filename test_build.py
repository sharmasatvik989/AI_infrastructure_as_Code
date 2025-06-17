import re
import requests

def test_hello_world():
    url= "http://localhost:30080"
    try:
        print(f"Sending a response to {url}")
        response = requests.get(url)

        if response.status_code == 200:
            print("✅ Hello World app is running!")
            print("📄 Sample Response:")
            print(response.text[:300]) 
        else:
            print(f"❌ Unexpected status code: {response.status_code}")
    except requests.exceptions.ConnectionError:
        print("❌ Failed to connect. Is Minikube running? Did Terraform apply?")
    except Exception as e:
        print(f"❌ Unexpected error: {e}")

if __name__ == "__main__":
    test_hello_world()