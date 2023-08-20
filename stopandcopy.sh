
# Set variables
CONTAINER_ORI=c1
CONTAINER_DESTI=c1dest
CHECKPOINT_DIR=/tmp/
DEST_HOST=host@192.16.
CHECKPOINT_NAME=clone
NOME_CONT_ORIGEM=74ad6f633c294d2d82868134dbb14cc084a9b9bf2f870285c85c04b287de6135
NOME_CONT_DESTI=9a15f70d15103e793877e31d64e53796d89c12f304f87444df0a4c3f8d1ee974


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


ssh -t $DEST_HOST "docker start --checkpoint $CHECKPOINT_NAME pasid"

fim_start=$(date "+%M:%S.%3N")
echo "fim do start: $fim_start"

echo ""
echo ""
echo ""


