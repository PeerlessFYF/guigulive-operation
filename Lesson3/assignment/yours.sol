<<<<<<< HEAD
pragma solidity ^0.4.14;

import "github.com/OpenZeppelin/zeppelin-solidity/contracts/math/SafeMath.sol";
import "github.com/OpenZeppelin/zeppelin-solidity/contracts/ownership/Ownable.sol";

contract Payroll is Ownable{
    using SafeMath for uint;
=======
/*作业请提交在这个目录下*/
//新增更改员工薪水的支付地址的函数
function changePaymentAddress(address employeeId, address newEmployeeId) onlyOwner employeeExist(employeeId) {
  var employee = employees[employeeId];
  
  employees[employeeId].id = newEmployeeId;
}

//加分题
L[O] = 0

L[A] = A + merge[L[0],0] 
     = [A,0]

L[B] = B + merge[L[0],0] 
     = [B,0]

L[C] = C + merge[L[0],0] 
     = [C,0]

L[K1] = K1 + merge[L[B],L[A],B,A]
      = K1 + merge[[B,0],[A,0],[B,A]]
      = [K1,B] + merge[[0],[A,0],[A]]
      = [K1,B,A,0]
      
L[K2] = K2 + merge[L[C],L[A],C,A]
      = K2 + merge[[C,0]],[A,0]],[C,A]]
      = [K2,C,A,0]

L[Z] = Z + merge[L[K2],L[K1],[K2,K1]]     
     = Z + merge[[K2,C,A,0],[K1,B,A,0],[K2,K1]]     
     = [Z,K2] + merge[[C,A,0],[B,A,0],K1]
     = [Z,K2,K1] + merge[[C,A,0],[B,A,0]]
     = [Z,K2,K1,C,A,B,0]


//源码
pragma solidity ^0.4.14;

contract Payroll {
>>>>>>> master
    struct Employee {
        address id;
        uint salary;
        uint lastPayday;
    }
<<<<<<< HEAD
    uint constant payDuration = 10 seconds;
    address owner;
    uint totalSalary  = 0;
    mapping(address => Employee) public employees;
    modifier employeeExist (address employeeId) {
        var employee = employees[employeeId];
        assert(employee.id != 0x0);
        _;
    }
    modifier employeeNotExist (address employeeId) {
        var employee = employees[employeeId];
        assert(employee.id == 0x0);
        _;
    }
    function _partialPaid(Employee employee) private {
            uint payment = employee.salary.mul(now.sub(employee.lastPayday)).div(payDuration);
            employee.id.transfer(payment);
    }
    function addEmployee(address employeeId, uint salary) onlyOwner employeeNotExist(employeeId) {
        totalSalary += salary.mul(1 ether);
        employees[employeeId] = Employee(employeeId, salary.mul(1 ether), now);
        
    }
    function removeEmployee(address employeeId) onlyOwner employeeExist(employeeId){
        _partialPaid(employees[employeeId]);
        totalSalary = totalSalary.sub(employees[employeeId].salary);
        delete employees[employeeId];
    }
    function updateEmployee(address employeeId, uint salary) onlyOwner employeeExist(employeeId){
        _partialPaid(employees[employeeId]);
        totalSalary = totalSalary.sub(employees[employeeId].salary);
        employees[employeeId].salary = salary.mul(1 ether);
        totalSalary = totalSalary.add(employees[employeeId].salary);
        employees[employeeId].lastPayday = now;
    }
    function changePaymentAddress(address employeeIdNew) employeeExist(msg.sender) {
        _partialPaid(employees[msg.sender]);
        var employee = employees[msg.sender];
        employees[employeeIdNew] = Employee(employeeIdNew, employee.salary, employee.lastPayday);
        delete employees[msg.sender];
    }
    function addFund() payable returns (uint) {
        return this.balance;
    }
    function calculateRunway() returns (uint) {
        return this.balance.div(totalSalary);
    }
    function hasEnoughFund() returns (bool) {
        return calculateRunway() > 0;
    }
    function getPaid() employeeExist(msg.sender){
        uint nextPayday = employees[msg.sender].lastPayday.add(payDuration);
        assert(nextPayday < now);
        employees[msg.sender].lastPayday = nextPayday;
        employees[msg.sender].id.transfer(employees[msg.sender].salary);
    }

}
=======
    
    uint constant payDuration = 10 seconds;
    
    uint totalSalary;
    address owner;
    mapping(address => Employee) public employees;

    function Payroll() {
        owner = msg.sender;
    }
    
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    modifier employeeExist(address employeeId) {
         var employee = employees[employeeId];
        assert(employee.id != 0x0);
        _;
    }
    
    function _partialPaid(Employee employee) private {
        uint payment = employee.salary * (now - employee.lastPayday) / payDuration;
        employee.id.transfer(payment);
    }
    
    function addEmployee(address employeeId, uint salary) onlyOwner {
        var employee = employees[employeeId];
        assert(employee.id == 0x0);
        totalSalary += salary * 1 ether;
        
        employees[employeeId] = Employee(employeeId, salary * 1 ether, now);
    }
    
    function removeEmployee(address employeeId) onlyOwner employeeExist(employeeId) {
        
        var employee = employees[employeeId];
        
        _partialPaid(employee);
        totalSalary -= employees[employeeId].salary;
        delete employees[employeeId];
        
    }
    
    function updateEmployee(address employeeId, uint salary) onlyOwner employeeExist(employeeId) {
        var employee = employees[employeeId];
        
        _partialPaid(employee);
        totalSalary -= employees[employeeId].salary;
        employees[employeeId].salary = salary * 1 ether;
        totalSalary += employees[employeeId].salary;
        employees[employeeId].lastPayday = now;
    }
    
    function addFund() payable returns (uint) {
        return this.balance;
    }
    
    function calculateRunway() returns (uint) {
        return this.balance / totalSalary;
    }
    
    function hasEnoughFund() returns (bool) {
        return calculateRunway() > 0;
    }
    
    function getPaid() employeeExist(msg.sender) {
        var employee = employees[msg.sender];
        
        uint nextPayday = employee.lastPayday + payDuration;
        assert(nextPayday < now);
        
        employees[msg.sender].lastPayday = nextPayday;
        employee.id.transfer(employee.salary);
    }
}
>>>>>>> master
