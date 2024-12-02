defmodule Decent.Native do
  @moduledoc false

  mix_config = Mix.Project.config()
  version = mix_config[:version]
  github_url = mix_config[:package][:links]["GitHub"]

  use RustlerPrecompiled,
    otp_app: :decent,
    crate: :decent,
    base_url: github_url <> "/releases/download/v" <> version,
    version: version,
    force_build: System.get_env("DECENT_BUILD") in ["1", "true"]

  @doc """
  Encrypts a message using a public key.
  """
  def encrypt(_message, _public_key),
    do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Decrypts a message using a private key.
  """
  def decrypt(_encrypted_message, _private_key, _private_key_passphrase \\ nil),
    do: :erlang.nif_error(:nif_not_loaded)
end
