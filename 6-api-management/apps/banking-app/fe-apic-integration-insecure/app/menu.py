import streamlit as st


def authenticated_menu():
    # Show a navigation menu for authenticated users
    st.sidebar.page_link("app.py", label="Service Selection")
    if st.session_state.service == "Transfer Money":
        st.sidebar.page_link("pages/money.py", label="Transfer Money")
    if st.session_state.service == "Give Feedback":
        st.sidebar.page_link("pages/feedback.py", label="Give Feedback")
    st.sidebar.page_link("pages/help.py", label="Need some help?")
    st.sidebar.page_link("pages/close-account.py", label="How to close my account")


def unauthenticated_menu():
    # Show a navigation menu for unauthenticated users
    st.sidebar.page_link("app.py", label="Service Selection")


def menu():
    # Determine if a user is logged in or not, then show the correct
    # navigation menu
    if "service" not in st.session_state or st.session_state.service is None:
        unauthenticated_menu()
        return
    authenticated_menu()


def menu_with_redirect():
    # Redirect users to the main page if not logged in, otherwise continue to
    # render the navigation menu
    if "service" not in st.session_state or st.session_state.service is None:
        st.switch_page("app.py")
    menu()
