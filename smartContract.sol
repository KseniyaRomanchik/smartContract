pragma solidity ^0.4.0;

struct Student {
    uint8 markSum;
    uint256 balance;
}

struct Teacher {
    uint256 balance;
}

contract UniversityStorage {

    uint totalBalance;
    
    mapping (address => Student) public students;
    mapping (address => Teacher) public teachers;

    function UniversityStorage(
        uint initialBalance
    ) {
        totalBalance = initialBalance;
        balanceOf[msg.sender] = totalSupply;
    }

    function addStudent(address studentAddress) public {

        require(students[studentAddress].isValue);
        students[studentAddress] = Student(0, 1);
    }

    function addTeacher(address teacherAddress, uint256 amount) public {

        require(teachers[teacherAddress].isValue);
        teachers[teacherAddress] = Teacher(amount);
    }
 
    function deleteStudent(address studentAddress) public {

        require(students[studentAddress].isValue);
        delete students[studentAddress];
    }

    function deleteTeacher(address teacherAddress) public {

        require(teachers[teacherAddress].isValue);
        delete teachers[teacherAddress];
    }

    function withdrawStudentBenefit(address studentAddress) {
        require(!students[studentAddress].isValue);
        require(totalBalance >= students[studentAddress].balance);

        totalBalance -= students[studentAddress].balance;
        students[studentAddress].balance = 0;
    }
}

contract UniversityController {

    function payingOfBenefits(address studentAddress) returns(bool success) {

        UniversityStorage.withdrawStudentBenefit(studentAddress);

        studentAddress.transfer(students[studentAddress].balance);

        return true;
    }
}