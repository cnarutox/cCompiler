/* Generated By:JavaCC: Do not edit this line. TempConstants.java */
package Try_Demo;


/**
 * Token literal values and constants.
 * Generated by org.javacc.parser.OtherFilesGen#start()
 */
public interface TempConstants {

  /** End of File. */
  int EOF = 0;
  /** RegularExpression Id. */
  int LINE_COMMIT = 6;
  /** RegularExpression Id. */
  int BLOCK_COMMIT = 9;
  /** RegularExpression Id. */
  int SEMIC = 10;
  /** RegularExpression Id. */
  int COMMA = 11;
  /** RegularExpression Id. */
  int COLON = 12;
  /** RegularExpression Id. */
  int ELLIPSIS = 13;
  /** RegularExpression Id. */
  int QUESTION = 14;
  /** RegularExpression Id. */
  int ASSIGN = 15;
  /** RegularExpression Id. */
  int MACRO = 16;
  /** RegularExpression Id. */
  int LBR = 17;
  /** RegularExpression Id. */
  int RBR = 18;
  /** RegularExpression Id. */
  int RCBR = 19;
  /** RegularExpression Id. */
  int LCBR = 20;
  /** RegularExpression Id. */
  int PLUS = 21;
  /** RegularExpression Id. */
  int MINUS = 22;
  /** RegularExpression Id. */
  int MULT = 23;
  /** RegularExpression Id. */
  int DIV = 24;
  /** RegularExpression Id. */
  int MOD = 25;
  /** RegularExpression Id. */
  int INC = 26;
  /** RegularExpression Id. */
  int DEC = 27;
  /** RegularExpression Id. */
  int EXLM = 28;
  /** RegularExpression Id. */
  int NOT = 29;
  /** RegularExpression Id. */
  int AND = 30;
  /** RegularExpression Id. */
  int OR = 31;
  /** RegularExpression Id. */
  int XOR = 32;
  /** RegularExpression Id. */
  int LOGIC_EQUAL = 33;
  /** RegularExpression Id. */
  int LOGIC_NOT = 34;
  /** RegularExpression Id. */
  int LOGIC_AND = 35;
  /** RegularExpression Id. */
  int LOGIC_OR = 36;
  /** RegularExpression Id. */
  int LEFT = 37;
  /** RegularExpression Id. */
  int RIGHT = 38;
  /** RegularExpression Id. */
  int LEFT_EQUAL = 39;
  /** RegularExpression Id. */
  int RIGHT_EQUAL = 40;
  /** RegularExpression Id. */
  int LEFT_MOVE = 41;
  /** RegularExpression Id. */
  int RIGHT_MOVE = 42;
  /** RegularExpression Id. */
  int ADD_EQUAL = 43;
  /** RegularExpression Id. */
  int MINUS_EQUAL = 44;
  /** RegularExpression Id. */
  int MULT_EQUAL = 45;
  /** RegularExpression Id. */
  int DIV_EQUAL = 46;
  /** RegularExpression Id. */
  int MOD_EQUAL = 47;
  /** RegularExpression Id. */
  int AND_EQUAL = 48;
  /** RegularExpression Id. */
  int OR_EQUAL = 49;
  /** RegularExpression Id. */
  int XOR_EQUAL = 50;
  /** RegularExpression Id. */
  int LEFT_MOVE_EQUAL = 51;
  /** RegularExpression Id. */
  int RIGHT_MOVE_EQUAL = 52;
  /** RegularExpression Id. */
  int BOOL = 53;
  /** RegularExpression Id. */
  int CONST = 54;
  /** RegularExpression Id. */
  int DO = 55;
  /** RegularExpression Id. */
  int ELSE = 56;
  /** RegularExpression Id. */
  int FALSE = 57;
  /** RegularExpression Id. */
  int IF = 58;
  /** RegularExpression Id. */
  int INT = 59;
  /** RegularExpression Id. */
  int RETURN = 60;
  /** RegularExpression Id. */
  int STR = 61;
  /** RegularExpression Id. */
  int TRUE = 62;
  /** RegularExpression Id. */
  int VOID = 63;
  /** RegularExpression Id. */
  int CHAR = 64;
  /** RegularExpression Id. */
  int SHORT = 65;
  /** RegularExpression Id. */
  int LONG = 66;
  /** RegularExpression Id. */
  int WHILE = 67;
  /** RegularExpression Id. */
  int INCLUDE = 68;
  /** RegularExpression Id. */
  int DEFINE = 69;
  /** RegularExpression Id. */
  int GOTO = 70;
  /** RegularExpression Id. */
  int FOR = 71;
  /** RegularExpression Id. */
  int SWITCH = 72;
  /** RegularExpression Id. */
  int CASE = 73;
  /** RegularExpression Id. */
  int CASE_DEFAULT = 74;
  /** RegularExpression Id. */
  int BREAK = 75;
  /** RegularExpression Id. */
  int CONTINUE = 76;
  /** RegularExpression Id. */
  int IDENTIFIER = 77;
  /** RegularExpression Id. */
  int INTEGER = 78;
  /** RegularExpression Id. */
  int STRING = 83;
  /** RegularExpression Id. */
  int CHARACTER = 88;
  /** RegularExpression Id. */
  int OTHER = 89;

  /** Lexical state. */
  int DEFAULT = 0;
  /** Lexical state. */
  int IN_BLOCK_COMMIT = 1;
  /** Lexical state. */
  int IN_STRING = 2;
  /** Lexical state. */
  int IN_CHARACTER = 3;
  /** Lexical state. */
  int CHARACTER_TERM = 4;

  /** Literal token values. */
  String[] tokenImage = {
    "<EOF>",
    "\" \"",
    "\"\\t\"",
    "\"\\n\"",
    "\"\\r\"",
    "\"\\f\"",
    "<LINE_COMMIT>",
    "\"/*\"",
    "<token of kind 8>",
    "\"*/\"",
    "\";\"",
    "\",\"",
    "\":\"",
    "\"...\"",
    "\"?\"",
    "\"=\"",
    "\"#\"",
    "\"(\"",
    "\")\"",
    "\"}\"",
    "\"{\"",
    "\"+\"",
    "\"-\"",
    "\"*\"",
    "\"/\"",
    "\"%\"",
    "\"++\"",
    "\"--\"",
    "\"!\"",
    "\"~\"",
    "\"&\"",
    "\"|\"",
    "\"^\"",
    "\"==\"",
    "\"!=\"",
    "\"&&\"",
    "\"||\"",
    "\"<\"",
    "\">\"",
    "\"<=\"",
    "\">=\"",
    "\"<<\"",
    "\">>\"",
    "\"+=\"",
    "\"-=\"",
    "\"*=\"",
    "\"/=\"",
    "\"%=\"",
    "\"&=\"",
    "\"|=\"",
    "\"^=\"",
    "\"<<=\"",
    "\">>=\"",
    "\"bool\"",
    "\"const\"",
    "\"do\"",
    "\"else\"",
    "\"false\"",
    "\"if\"",
    "\"int\"",
    "\"return\"",
    "\"string\"",
    "\"true\"",
    "\"void\"",
    "\"char\"",
    "\"short\"",
    "\"long\"",
    "\"while\"",
    "\"include\"",
    "\"define\"",
    "\"goto\"",
    "\"for\"",
    "\"switch\"",
    "\"case\"",
    "\"default\"",
    "\"break\"",
    "\"continue\"",
    "<IDENTIFIER>",
    "<INTEGER>",
    "\"\\\"\"",
    "<token of kind 80>",
    "<token of kind 81>",
    "<token of kind 82>",
    "\"\\\"\"",
    "\"\\\'\"",
    "<token of kind 85>",
    "<token of kind 86>",
    "<token of kind 87>",
    "\"\\\'\"",
    "<OTHER>",
  };

}
