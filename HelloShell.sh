read -p "What is your name?" AWR

# number: -eq -ne -gt -ge -lt -le
# string: = != -n -z 
if [ "$AWR" = "Thiago" -o "$AWR" = "sudo" ]
then
  echo "Welcome back, sir!"
fi

printAnswer () {
  echo "Your answer: $1"
}
printAnswer $AWR

case $AWR in
  [0-9])
    echo "It is a number"
    ;;
  Jo)
    echo "Hello Jo"
    ;;
  finish)
    exit 0
    ;;
esac

echo "Program name: $1 \nNumber of parameters: $#\nParameters: $*\nFirst parameter: $0"

for param in $*
do
  echo "Param: $param"
done

KERNEL=$(uname -r)
HOSTNAME=$(hostname)
CPUNO=$(cat /proc/cpuinfo |grep "model name"|wc -l)
CPUMODEL=$(cat /proc/cpuinfo |grep "model name"|head -n1|cut -c14-)
MEMTOTAL=$(expr $(cat /proc/meminfo |grep MemTotal|tr -d ' '|cut -d: -f2|tr -d kB) / 1024) # Em MB
FILESYS=$(df -h|egrep -v '(tmpfs|udev)')
UPTIME=$(uptime -s)

echo "=================================================================="
echo "Relatório da Máquina: $HOSTNAME"
echo "Data/Hora: $(date +%d/%m/%y-%H:%M)"
echo "=================================================================="
echo 
echo "Máquina Ativa desde: $UPTIME"
echo
echo "Versão do Kernel: $KERNEL"
echo
echo "CPUs:"
echo "Quantidade de CPUs/Core: $CPUNO"
echo "Modelo da CPU: $CPUMODEL"
echo
echo "Memória Total: $MEMTOTAL MB"
echo
echo "Partições:"
echo "$FILESYS"
echo
echo "=================================================================="

if [ -n "$1" ]
then
  echo "Start user search: $1"

  ls /home/$1 > /dev/null 2>&1 || { echo "Usuario Inexistente" ; exit 1; }

  USERID=$(grep $1 /etc/passwd|cut -d":" -f3)
  DESC=$(grep $1 /etc/passwd|cut -d":" -f5 | tr -d ,)
  USOHOME=$(du -sh /home/$1|cut -f1)

  echo "=========================================================================="
  echo "Relatório do Usuário: $1"
  echo
  echo "UID: $USERID"
  echo "Nome ou Descrição: $DESC"
  echo
  echo "Total Usado no /home/$1: $USOHOME"
  echo
  echo "Ultimo Login:"
  lastlog -u $1
  echo "=========================================================================="
fi

exit 0

