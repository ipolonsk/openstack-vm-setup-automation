# This is the template for the ansible inventory
[vm]
%{ for ip in vms_ips ~}
${ip}
%{ endfor ~}

[dev]

