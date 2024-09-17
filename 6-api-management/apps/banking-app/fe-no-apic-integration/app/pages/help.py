from menu import menu_with_redirect
import streamlit as st

# Redirect to app.py if not logged in, otherwise show the navigation menu
menu_with_redirect()


st.header("Help Page", divider='blue')
st.markdown(f"Hello! Simply click on **{st.session_state.service}** found one tab below and start chatting away!")
st.markdown("The chatbox will be found towards the bottom of the page.")
st.markdown("When initiating transfers, please follow the following format: Transfer X$ to ABC where X is an integer"
            " and ABC is the customer name in question")
st.markdown("When giving feedback, simply answer the questions provided.")
st.markdown("Its that simple!")
