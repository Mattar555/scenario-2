import streamlit as st

import http_client
from menu import menu_with_redirect

menu_with_redirect()

st.header("Transfer", divider='blue')
st.markdown(f"Hello! Simply click on **{st.session_state.service}** found one tab below and start chatting away!")
st.markdown("The chatbox will be found towards the bottom of the page.")


# Initialize chat history. We simulate each new conversation with a new user with a random identifier.
# In a production setting, the user ID must be sourced from upstream authentication provider (eg, using OIDC protocol)
if "transfer_transactions" not in st.session_state:

    st.session_state.transfer_transactions = []

for message in st.session_state.transfer_transactions:
    with st.chat_message(message["role"]):
        st.markdown(message["content"])

if prompt := st.chat_input("Allow me to perform a transfer.."):
    st.chat_message("user").markdown(prompt)
    st.session_state.transfer_transactions.append(
        {
            "role": "user",
            "content": prompt
        }
    )

    with st.chat_message("assistant"):
        response = st.write_stream(http_client.perform_transfer(prompt, st.session_state.customer_id))
    st.session_state.transfer_transactions.append(
        {
            "role": "assistant",
            "content": response
        }
    )
