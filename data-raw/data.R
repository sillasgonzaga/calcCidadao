inflation_indices <- c(
  "IGP-M" = "00189IGP-M",
  "IGP-DI" = "00190IGP-DI",
  "INPC" = "00188INPC",
  "IPC-A" = "00433IPC-A",
  "IPCA-E" = "10764IPC-E",
  "IPC-BRASIL" = "00191IPC-BRASIL",
  "IPC-SP" = "00193IPC-SP"
  )

inflation_index_names <- names(inflation_indices)
inflation_index_codes <- unname(inflation_indices)

devtools::use_data(inflation_index_names)
devtools::use_data(inflation_index_codes)
