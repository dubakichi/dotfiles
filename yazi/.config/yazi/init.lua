function Linemode:size_and_mtime()
  -- 最終更新日時
	local time = math.floor(self._file.cha.mtime or 0)
	if time == 0 then
		time = ""
	else
		time = os.date("%Y/%m/%d %H:%M:%S", time)
	end
	-- ファイルサイズ
	local size = self._file:size()

	local user = ya.user_name(self._file.cha.uid) or tostring(self._file.cha.uid)
	return string.format(
		"%s %s %s",
		size and ya.readable_size(size) or "-",
		user,
		time
	)
end
