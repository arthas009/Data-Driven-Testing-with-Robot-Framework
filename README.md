# Data Driven Testing with Robot Framework
 Includes sample test case(s) for Data Driven approach using Robot Framework. 
 Used page object model approach, data driven approach together.

# Prerequisites
 * Python 3.9
 * pip install --upgrade robotframework
 * pip install --upgrade robotframework-seleniumlibrary
 * pip install --upgrade robotframework-excellibrary
 
 # Execution
 Go to repository folder -> starter script folder 
  * cd .\starter_script\
 
 Execute the following command for execution of robot framework based on tag. 
  * python -u ./runner.py -i text_searching
OR
  * python -u ./runner.py -i invalid_login
 
 .yaml files are chosen by tag name of test case being executed.
