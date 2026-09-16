import '../models/transaction.dart';



// Rule 1
// Balance = Income - Expense

int calculateBalance(
    List<Transaction> data){

  int income = 0;

  int expense = 0;



  for(var item in data){


    if(item.type == "Income"){


      income += item.amount;


    }

    else{


      expense += item.amount;


    }


  }



  return income - expense;


}






// Rule 2

String checkBalanceStatus(
    List<Transaction> data){


  if(calculateBalance(data) < 0){


    return "Exceeds balance";


  }


  return "Safe";


}






// Rule 3

bool isValidAmount(int amount){


  return amount > 0;


}