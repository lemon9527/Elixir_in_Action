defmodule Calculator do
  def add(a), do: add(a, 0) # Calculator.add/1 delegates to Calculator.add/2
  def add(a, b), do: a + b
end

defmodule Scan_card do
  def scan() do
    alias Circuits.I2C
    {:ok, ref} = I2C.open("i2c-1")
    I2C.write(ref, 0x50, <<0x03, 0x03, 0x00, 0x00>>)
    Process.sleep(50)
    temp = read_until_ok(ref)
    temp
  end

  defp read_until_ok(ref) do
    case Circuits.I2C.read(ref, 0x50, 7) do
      {:ok, _data} = result -> result
      {:error, :i2c_nak} ->
        Process.sleep(15)
        read_until_ok(ref)
      other -> other
    end
  end
end
