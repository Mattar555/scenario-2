import streamlit as st

from menu import menu_with_redirect

menu_with_redirect()

st.header("Feedback Page", divider='blue')
st.markdown(f"Hello! Simply click on **{st.session_state.service}** found one tab below and start chatting away!")
st.markdown("The chatbox will be found towards the bottom of the page.")