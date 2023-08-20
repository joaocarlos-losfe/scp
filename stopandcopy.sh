
# Set variables
CONTAINER_ORI=c1
CONTAINER_DESTI=c2
CHECKPOINT_DIR=/tmp/
DEST_HOST=host@192.168.1.4
CHECKPOINT_NAME=clone
NOME_CONT_ORIGEM=df26f1ca1ef7324bad65a6798b7ab940686f449694e1c3c41866bda7778d1232
NOME_CONT_DESTI=a10fbf6ec47a46c0359d63aa29fcdff659551bae4cd004635be16be145a51e7d


inicio_check=$(date "+%M:%S.%3N")
echo "inicio do checkpoint: $inicio_check"
echo ""
echo ""
echo ""

docker checkpoint create --leave-running pasid $CHECKPOINT_NAME
fim_check=$(date "+%M:%S.%3N")

echo ""
echo ""
echo ""

echo "fim do checkpoint: $fim_check"

echo ""
echo ""
echo ""


inicio_cop=$(date "+%M:%S.%3N")
echo "inicio da copia: $inicio_cop"

echo ""
echo ""
echo ""

scp -r /var/lib/docker/containers/$NOME_CONT_ORIGEM/checkpoints/ $DEST_HOST:$CHECKPOINT_DIR
ssh -t $DEST_HOST "cp -r /tmp/checkpoints/ /var/lib/docker/containers/$NOME_CONT_DESTI/"

echo ""
echo ""
echo ""


fim_cop=$(date "+%M:%S.%3N")
echo "fim da copia: $fim_cop"

echo ""
echo ""
echo ""



inicio_start=$(date "+%M:%S.%3N")
echo "inicio do start: $inicio_start"
echo ""
echo ""
echo ""


ssh -t $DEST_HOST "docker start --checkpoint $CHECKPOINT_NAME check1"

fim_start=$(date "+%M:%S.%3N")
echo "fim do start: $fim_start"

echo ""
echo ""
echo ""