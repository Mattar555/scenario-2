import os
import http_client
from menu import menu
import streamlit as st

API_KEY = os.environ.get("PASSWORD")
if API_KEY is None:
    raise ValueError("API key is not set. Please set the API key in your environment variables.")


# Initialize st.session_state.role to None
if "service" not in st.session_state:
    st.session_state.service = None
    st.session_state.auth = False

# Retrieve the service from Session State to initialize the widget
st.session_state._service = st.session_state.service


def authenticate_api_key(api_key):
    if api_key != API_KEY:
        return False
    return True


def set_service():
    # Callback function to save the role selection to Session State
    st.session_state.service = st.session_state._service


def main():
    st.title("IBM/Leonardo Enablement Application")

    if not st.session_state.auth:
        api_key = st.text_input("Enter your credentials:", type="password")
        if not authenticate_api_key(api_key):
            st.error("Invalid credentials. Access denied.")
            st.stop()
        else:
            http_client.cache_customer_details()
            st.session_state.customer_id = http_client.set_customer()
            st.session_state.auth = True

    st.title('Superior Banking Application :cucumber:')
    st.header('With :heart: from the IBM App Mod Team', divider='blue')
    # Product Selection Box
    st.markdown(
        "Hello and Welcome! Thank you for stopping by, using our friendly chatbot, you can now perform transfers"
        " whenever, wherever.")
    st.markdown(
        "We also run the feedback application. Do feel free to provide feedback, positive or negative, on the goods"
        " and services our company provides. Our bots will do our best to help you.")
    st.markdown("Once you've selected your service, headover to the **need some help** tab to get started.")
    st.selectbox(
        "Select your service",
        [
            None,
            "Transfer Money",
            "Give Feedback",
        ],
        key="_service",
        on_change=set_service,
    )

    menu()


if __name__ == "__main__":
    main()
