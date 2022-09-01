"""

DOCUMENTATION:

Test runner engine for executing tests on windows and unix OS

USAGE EXAMPLES:

python -u runner.py --tag smoke --etag criticalORui --ip 172.24.168.185
python -u runner.py -i fute -e critical

NOTES:
    Running in local, do not give ip
    Running in jenkins, give execution machine ip

"""

import argparse
import sys
import os
import subprocess

DEFAULT_LIB_PATH = "/../library"
DEFAULT_SUITE_PATH = "/.."
DEFAULT_RESOURCES_FOLDER = "/library"
DEFAULT_RESULT_FOLDER = "/result"
DEFAULT_ARG_FOLDER = "/library/argument_files/"
DEFAULT_PYTHON_FOLDER = "C:/Users/yusuf/AppData/Local/Programs/Python/Python310"

class RobotCaseRunner(object):

    def __init__(self, arguments):
        self.cur_path = os.getcwd()
        self.TAG = arguments.tag
        self.ETAG = arguments.etag
        self.IP = arguments.ip
        self.LANG = arguments.language
        self.SW_FILE_PATH = arguments.swfile

        try:
            self.var_file = self.__validate_var_file()
        except FileNotFoundError as e:
            print(e)
            exit(1)

    def __validate_var_file(self):
        """

        Validating variable file to use (local or jenkins)

        :return:
        """

        print("Resolving var file....")
        var_file = os.path.normpath(self.cur_path + DEFAULT_SUITE_PATH + DEFAULT_ARG_FOLDER + self.TAG + ".yaml")
        if os.path.isfile(var_file):
            print("Using var file: {}".format(var_file))
            return var_file
        else:
            raise FileNotFoundError("No such var file '{0}' found!".format("localhost.yaml"))

    def execute(self):
        """

        Executes tests with given command line args
        Uses some hard coded arguments: -e donotrunOR3.8.0.0OR3.8.1.0 -L TRACE:INFO

        :return:
        """

        print("\nRunning on platform: {} \n".format(_check_platform()))
        run_command(self.get_call())

    def get_call(self):
        """

        Returns correct call to be executed

        :return: robot call to be executed
        """

        lib_pythonpath = self.cur_path + DEFAULT_LIB_PATH
        resources_pythonpath = self.cur_path + DEFAULT_SUITE_PATH + DEFAULT_RESOURCES_FOLDER
        pythonpath = os.path.normpath(self.cur_path + ":" + lib_pythonpath + ":" + resources_pythonpath + ":" + DEFAULT_PYTHON_FOLDER)
        result_path = os.path.normpath(self.cur_path + DEFAULT_SUITE_PATH + DEFAULT_RESULT_FOLDER)
        suite_path = os.path.normpath(self.cur_path + DEFAULT_SUITE_PATH)
        arg_call = "robot -P {0} -V {1} -d {2} -e donotrun -L TRACE:INFO -i {3} ".format(
            pythonpath, self.var_file, result_path, self.TAG)

        if self.ETAG is not None:
            arg_call = arg_call + "-e {0} ".format(self.ETAG)
  
        print("PYTHONPATH: {0} \n".format(pythonpath))

        return arg_call + suite_path


def _check_platform():
    """

    Check on what platform is in use

    :return: platform type: win32 or linux
    """
    return sys.platform


def run_command(call):
    """

    Runs given command

    :param call: robot command
    :return:
    """
    print("ROBOT COMMAND TO EXECUTE: {0}".format(call))

    try:
        subprocess.check_call(call, shell=True, stderr=subprocess.STDOUT)

    except subprocess.CalledProcessError:
        pass


def parse_args():
    """

    Argument parser

    :return: arguments
    """
    parser = argparse.ArgumentParser(description="Test execution tool")
    parser.add_argument('--tag', '-i', help="Give tag to run (include tag)")
    parser.add_argument('--etag', '-e', help="Give tag to exclude from run (exclude tag)")
    parser.add_argument('--ip', '-ip',
                        help="Give target machine ip if running in jenkins! (do not give ip if running in local")
    parser.add_argument('--language', '-l', help="Give language e.g 'English' if help testing")
    parser.add_argument('--swfile', '-sw', help="Give software file path (folder where sw file is located) e.g "
                                            "http://jemma.vaisala.com/pub/builds/rws200/release/latest/aws_cpu/images/")
    arguments = parser.parse_args()

    if arguments.tag is None:
        print("Mandatory argument '--tag' missing!")
        exit(1)
    if arguments.ip is None:
        print("\nRunning in local environment!")
    else:
        print("\nRunning in jenkins environment!")

    return arguments


args = parse_args()
ex = RobotCaseRunner(args)
ex.execute()