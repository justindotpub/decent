defmodule Decent do
  @moduledoc """
  Functions for encrypting and decrypting messages using PGP.
  """

  @doc """
  Encrypts a message using a public key.
  """
  defdelegate encrypt(message, public_key), to: Decent.Native

  @doc """
  Decrypts a message using a private key.
  """
  defdelegate decrypt(encrypted_message, private_key, private_key_passphrase \\ nil),
    to: Decent.Native
end
