# JavaScript Code Linter

In this project, I used my knowledge of Ruby to build a code linter for detecting syntax errors in basic JavaScript code. The linter inspects each line of code in a JavaScript file, detects any syntax errors that may be present, and outputs a message describing each error that it finds.

The following are some examples of how the tool responds to good and bad code:

### *Bad Code:*

In the screenshot below, line 5 does not end with a semicolon.

![Bad Code 3](https://user-images.githubusercontent.com/70488620/119077456-4bb6d780-b9c2-11eb-8e46-5cfd3838644a.PNG)

The linter detects this and indicates it to the user.

![Linter Error 3](https://user-images.githubusercontent.com/70488620/119077506-5c674d80-b9c2-11eb-83d4-7f14f617b695.PNG)

### *Good Code*

In the screenshot below, a semicolon is written at the end of line 5.

![Good Code 3](https://user-images.githubusercontent.com/70488620/119077619-9e908f00-b9c2-11eb-844c-0a4d275661b3.PNG)

The linter then detects that there are no more errors left in the code.

![Linter Pass 3](https://user-images.githubusercontent.com/70488620/119077649-aea86e80-b9c2-11eb-8b46-79a227a385f8.PNG)

### *Bad Code:*

In the screenshot below, the first line in the function has an incorrect indentation.

![Bad Code 1](https://user-images.githubusercontent.com/70488620/118889256-dae0c400-b8ca-11eb-95d9-b2e9bdeda6b1.PNG)

The linter detects this and indicates it to the user.

![Linter error 1](https://user-images.githubusercontent.com/70488620/118889137-aff67000-b8ca-11eb-8d33-1e6ce96d21ef.PNG)

### *Good Code*

In the screenshot below, the indentation of line 7 is corrected.

![image](https://user-images.githubusercontent.com/70488620/118889562-4591ff80-b8cb-11eb-84ba-136dc3ae1ead.png)

The linter then detects that there are no more errors left in the code.

![Linter Pass 1](https://user-images.githubusercontent.com/70488620/118889639-635f6480-b8cb-11eb-9e0a-3092b98439a3.PNG)

### *Bad Code:*

In the screenshot below, the curly braces of the add function are not closed.

![Bad Code 2](https://user-images.githubusercontent.com/70488620/118889867-c0f3b100-b8cb-11eb-8fb5-04c2740f17e7.PNG)

The linter detects this and indicates it to the user.

![Linter Error 2](https://user-images.githubusercontent.com/70488620/118890025-fd271180-b8cb-11eb-9b0d-c29f0cd05d71.PNG)

### *Good Code*

In the screenshot below, the curly braces of the add function are closed.

![Good Code 2](https://user-images.githubusercontent.com/70488620/118890126-28116580-b8cc-11eb-80b0-9f83f7629e5b.PNG)

The linter then detects that there are no more errors left in the code.

![Linter Pass 2](https://user-images.githubusercontent.com/70488620/118890221-52632300-b8cc-11eb-8c58-66de42aacaff.PNG)

### *Bad Code:*

In the screenshot below, there is no colon at the end of the case clause.

![Bad Code 4](https://user-images.githubusercontent.com/70488620/119078041-6d648e80-b9c3-11eb-8ece-9994bcf9c617.PNG)

The linter detects this and indicates it to the user.

![Linter Error 4](https://user-images.githubusercontent.com/70488620/119078067-77868d00-b9c3-11eb-8e92-d97ad623ebe4.PNG)

### *Good Code*

In the screenshot below, a colon is written at the end of the case clause.

![Good Code 4](https://user-images.githubusercontent.com/70488620/119078110-908f3e00-b9c3-11eb-9896-3d6281beb58a.PNG)

The linter then detects that there are no more errors left in the code.

![Linter Pass 4](https://user-images.githubusercontent.com/70488620/119078166-abfa4900-b9c3-11eb-9701-a3fafd2f1fbc.PNG)

## Built With
- Ruby

## Getting Started
- To make a copy of the project on your local machine, you can either download the project files in a zip folder or type git clone into your git commandline followed by the URL of this repository.
- Once you have downloaded a copy of the project to your local machine, navigate to the project directory, open the file named code.js, and write some basic JavaScript code in it.
- After you finish writing your JavaScript code in code.js, you can open your terminal in the project directory and run the code linter by entering 'ruby js_code_linter.rb' into your terminal.
- The code linter should then display messages to your terminal which describe any errors that may have been detected in your JavaScript code.

## Author

👤 **Yuvraj Manoo**
- Github: [@YuvrajM108](https://github.com/YuvrajM108/)
- LinkedIn: [Yuvraj Manoo](https://www.linkedin.com/in/yuvraj-manoo-2711a91b0/)

## Show your support
Give a ⭐️ if you like this project!
