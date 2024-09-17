from menu import menu_with_redirect
import streamlit as st

# Redirect to app.py if not logged in, otherwise show the navigation menu
menu_with_redirect()

st.header("How to Close my Account", divider='blue')
st.markdown('''

            The App Modernisation and Integration tech sales team value your privacy and understand that sometimes you may want to close your account.
            Follow the simple steps below to securely close your account with us.
''')
st.divider()
st.markdown('''
        ### Steps to Close Your Account:

        1. **Log In to Your Account:**
            - Go to our website and log in using your username and password.

        2. **Navigate to Account Settings:**
            - Once logged in, click on your profile icon in the top-right corner.
            - From the dropdown menu, select "Account Settings."

        3. **Select “Close Account”:**
            - Scroll down to the bottom of the Account Settings page.
            - Click on the "Close Account" button.

        4. **Confirm Your Decision:**
            - A confirmation prompt will appear asking if you're sure you want to close your account. Please read the information carefully, as this action is irreversible.
            - If you wish to proceed, click on the "Confirm Closure" button.

        5. **Final Verification:**
            - For security reasons, you may be asked to enter your password again to verify your identity.
            - After verification, your account will be permanently closed.

        ### What Happens After Closing Your Account?
            - Data Deletion All your personal data will be permanently deleted from our servers.
            - Service Access: 
            - Account Recovery:      
        ### Need Help?

        If you encounter any issues while trying to close your account or have any questions, our support team is here to assist you. Please contact us at [support email] or [support phone number].
        ''')
