defmodule Scan_card do
  def scan() do
    alias Circuits.I2C
    {:ok, ref} = I2C.open("i2c-1")
    # 发送scan_card命令
    I2C.write(ref, 0x50, <<0x03, 0x03, 0x00, 0x00>>)
    Process.sleep(30)
    case ack_polling(ref, 0x50) do
      :ready ->
        Circuits.I2C.read(ref, 0x50, 7)
      {:error, reason} ->
        {:error, reason}
    end
  end

  # 不发送寄存器地址，这个器件不需要
  # 只尝试与器件建立写事务，判断是否 ACK
  # 成功表示 器件 写周期完成，可以开始读取
  @doc """
  因为 器件在查询命令执行中会 NAK 所有事务，包括读和写
  但 Linux 的 i2c-dev 驱动在读失败时会报 :"No such device or address"
  而写失败时只会返回 {:error, _}，更适合用于 ACK polling
  """
  def ack_polling(i2c, addr, retries \\ 20, delay_ms \\ 15) do
    Enum.reduce_while(1..retries, {:error, :not_ready}, fn count, _ ->
      IO.puts("Polling attempt #{count} for device at address #{addr}")

      case Circuits.I2C.write(i2c, addr, <<>>) do
        :ok -> {:halt, :ready}
        {:error, _} -> Process.sleep(delay_ms); {:cont, {:error, :not_ready}}
      end
    end)
  end

end
