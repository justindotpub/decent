defmodule DecentTest do
  use ExUnit.Case
  doctest Decent

  setup do
    pub_key = File.read!(Path.expand("../priv/test_keys/decent.pub.asc", __DIR__))
    priv_key = File.read!(Path.expand("../priv/test_keys/decent.priv.asc", __DIR__))

    pub_key_without_passphrase =
      File.read!(Path.expand("../priv/test_keys/decent-without-passphrase.pub.asc", __DIR__))

    priv_key_without_passphrase =
      File.read!(Path.expand("../priv/test_keys/decent-without-passphrase.priv.asc", __DIR__))

    bad_pub_key = File.read!(Path.expand("../priv/test_keys/bad.pub.asc", __DIR__))
    bad_priv_key = File.read!(Path.expand("../priv/test_keys/bad.priv.asc", __DIR__))
    priv_key_passphrase = "passphrase"
    bad_priv_key_passphrase = "bad passphrase"

    {:ok,
     pub_key: pub_key,
     priv_key: priv_key,
     priv_key_without_passphrase: priv_key_without_passphrase,
     bad_pub_key: bad_pub_key,
     bad_priv_key: bad_priv_key,
     priv_key_passphrase: priv_key_passphrase,
     pub_key_without_passphrase: pub_key_without_passphrase,
     bad_priv_key_passphrase: bad_priv_key_passphrase}
  end

  test "encrypt and decrypt with passphrase", %{
    pub_key: pub_key,
    priv_key: priv_key,
    priv_key_passphrase: priv_key_passphrase
  } do
    plain_text = "this is a test"

    assert {:ok, encrypted} = Decent.encrypt(plain_text, pub_key)

    assert {:ok, decrypted} =
             Decent.decrypt(encrypted, priv_key, priv_key_passphrase)

    assert decrypted == plain_text
  end

  test "encrypt and decrypt without passphrase", %{
    pub_key_without_passphrase: pub_key_without_passphrase,
    priv_key_without_passphrase: priv_key_without_passphrase
  } do
    plain_text = "this is a test"

    assert {:ok, encrypted} = Decent.encrypt(plain_text, pub_key_without_passphrase)

    assert {:ok, decrypted} = Decent.decrypt(encrypted, priv_key_without_passphrase)

    assert decrypted == plain_text
  end

  test "decrypt with bad passphrase", %{
    pub_key: pub_key,
    priv_key: priv_key,
    bad_priv_key_passphrase: bad_priv_key_passphrase
  } do
    plain_text = "this is a test"

    assert {:ok, encrypted} = Decent.encrypt(plain_text, pub_key)

    assert {:error, "Incorrect passphrase"} =
             Decent.decrypt(encrypted, priv_key, bad_priv_key_passphrase)
  end

  test "encrypt with bad public key", %{bad_pub_key: bad_pub_key} do
    plain_text = "this is a test"

    assert {:error, "Invalid public key format"} =
             Decent.encrypt(plain_text, bad_pub_key)
  end

  test "decrypt with a bad private key", %{
    pub_key: pub_key,
    bad_priv_key: bad_priv_key,
    priv_key_passphrase: priv_key_passphrase
  } do
    plain_text = "this is a test"

    assert {:ok, encrypted} = Decent.encrypt(plain_text, pub_key)

    assert {:error, "Invalid private key format"} =
             Decent.decrypt(encrypted, bad_priv_key, priv_key_passphrase)

    assert {:error, "Invalid private key format"} =
             Decent.decrypt(encrypted, bad_priv_key)
  end

  test "encrypt and decrypt with different text lengths", %{
    pub_key: pub_key,
    priv_key: priv_key,
    priv_key_passphrase: priv_key_passphrase
  } do
    short_text = "short"
    long_text = String.duplicate("long text ", 1000)

    assert {:ok, encrypted_short} = Decent.encrypt(short_text, pub_key)

    assert {:ok, decrypted_short} =
             Decent.decrypt(encrypted_short, priv_key, priv_key_passphrase)

    assert decrypted_short == short_text

    assert {:ok, encrypted_long} = Decent.encrypt(long_text, pub_key)

    assert {:ok, decrypted_long} =
             Decent.decrypt(encrypted_long, priv_key, priv_key_passphrase)

    assert decrypted_long == long_text
  end

  test "decrypt with incorrect private key", %{
    pub_key: pub_key,
    priv_key_without_passphrase: priv_key_without_passphrase
  } do
    plain_text = "this is a test"

    assert {:ok, encrypted} = Decent.encrypt(plain_text, pub_key)

    assert {:error, "Decryption failed: MissingKey"} =
             Decent.decrypt(encrypted, priv_key_without_passphrase)
  end
end
