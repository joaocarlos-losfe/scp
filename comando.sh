#variaveis
host_destino="joanny"@192.168.1.4
pass="9009"
container_origem="df2"
container_destino="a10"
checkpoint_dir="~/docker_checkpoints"

#copia dos arquivos para migração
echo "Inicio da copia:"
echo ""

sshpass -p "$pass" scp -r /var/lib/docker/containers/"$container_origem"/checkpoints/ "$host_destino":"$checkpoint_dir"
sshpass -p "$pass" ssh -t "$host_destino" "cp -r "$checkpoint_dir/checkpoints/*"
/var/lib/docker/containers/"$container_destino"/checkpoints/"

echo "copiado"
echo ""

echo "restaurando"
echo ""
sshpass -p "$pass" ssh -t "$host_destino" "docker start --checkpoint check1 $container_destino" 

echo "fim da migração"
echo ""