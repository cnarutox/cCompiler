	%{
	/****************************************************************************
	myparser.y
	ParserWizard generated YACC file.

	Date: 2018��10��28��
	****************************************************************************/
	#include "define.h"
	#include "mylexer.h"
	void compare_traverse(typenode *root, vector<string> &v) {
		if(root!=NULL)
			v.push_back(root->name);
		if(root->left!=NULL)
		{
			traverse(root->left);
		}
		if(root->right!=NULL)
		{
			traverse(root->right);	
		}
	}
	void show_vector(vector<typenode*> &v){
		vector<typenode*>::iterator iter;
		for (iter=v.begin();iter!=v.end();iter++){
			// cout<<(*iter)->name<<' ';
		}
		// cout<<endl;
	}

	void show_string(vector<string> &v) {
		// for(int i=0; i<v.size();i++) {
		// 	cout<<v[i]<<" ";
		// }
		// cout<<endl;
	}

	void post_traverse(typenode* root, vector<string> &v_temp)
	{	
		if(root!=NULL){
			post_traverse(root->left, v_temp);
			post_traverse(root->right, v_temp);
			v_temp.push_back(root->name);
		}	
	}

	bool check_type(typenode* tp1, typenode* tp2){
		vector<string> temp1;
		vector<string> temp2;
		post_traverse(tp1, temp1);
		post_traverse(tp2, temp2);
		show_string(temp1);
		show_string(temp2);
		if (temp1.size() != temp2.size())
			return false;
		for(int i = 0; i < temp1.size(); i++) {
			if (temp1[i] != temp2[i]){
				if(temp2[i] == "double" && isComputable(temp1[i])||temp1[i] == "double" && isComputable(temp2[i]))
				{
					cout<<endl<<"---------------------------\n";
					cout<<"|warning: lose precision!!|\n";
					cout<<"---------------------------\n";
					return true;
				}
				return false;
			}
		}
		return true;
	}

	void search_struct(typenode *root, string name, typenode &p, int &addr) {
		//cout << '~\n';
		if(root == NULL)
		{
			//cout << "root->left->name == name" << endl;
		}
		if(root->left != NULL)
		{
			//cout << "left " << root->left->name << endl;
			if (root->left->name == name)
			{
				//cout << "into left\n";
				p = *(root -> right);
				addr = root->left->addr;
			} 
			else search_struct(root->left, name, p, addr);
		}
		if(root->right != NULL)
		{
			//cout << "right " << root->right->name << endl;
			search_struct(root->right, name, p, addr);
		}
	}

	%}
	%union {
		struct node* ntnode;
		int value;
	}

	%type <ntnode> primary_exp, postfix_exp,argument_exp_list, default_pre
	%type <ntnode> unary_exp,unary_operator,cast_exp,multiplicative_exp
	%type <ntnode> additive_exp,shift_exp,relational_exp,equality_exp
	%type <ntnode> and_exp,exclusive_or_exp,inclusive_or_exp
	%type <ntnode> logical_and_exp,logical_or_exp,conditional_exp
	%type <ntnode> assignment_exp,assignment_operator,exp
	%type <ntnode> constant_exp,declaration,declaration_specifiers
	%type <ntnode> init_declarator_list,init_declarator,storage_class_specifier,struct_or_union_def,def_concat
	%type <ntnode> type_specifier,struct_or_union_specifier,struct_or_union,struct_declaration_list
	%type <ntnode> struct_declaration,specifier_qualifier_list,struct_declarator_list,struct_declarator
	%type <ntnode> enum_specifier,enumerator_list,enumerator,type_qualifier,declarator,direct_declarator
	%type <ntnode> pointer,type_qualifier_list,parameter_type_list,parameter_list,parameter_declaration
	%type <ntnode> identifier_list,type_name,abstract_declarator,direct_abstract_declarator
	%type <ntnode> initializer,initializer_list,statement,labeled_statement,compound_statement
	%type <ntnode> declaration_list,statement_list,exp_statement
	%type <ntnode> iteration_statement,jump_statement,translation_unit,external_declaration
	%type <ntnode> function_definition,selection_statement,M, N, P, switch_pre
	%type <ntnode> open_statement, matched_statement, stmt,other,direct_pre_declarator





	/////////////////////////////////////////////////////////////////////////////
	// declarations section
	// parser name
	%token ID CONSTANT STRING_LITERAL SIZEOF
	%token PTR_OP INC_OP DEC_OP LEFT_OP RIGHT_OP LE_OP GE_OP EQ_OP NE_OP
	%token AND_OP OR_OP MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN ADD_ASSIGN
	%token SUB_ASSIGN LEFT_ASSIGN RIGHT_ASSIGN DIV_ASSIGN AND_ASSIGN
	%token XOR_ASSIGN OR_ASSIGN TYPE_NAME
	%token TRUE, FALSE

	%token TYPEDEF EXTERN STATIC AUTO REGISTER
	%token CHAR SHORT INT LONG SIGNED UNSIGNED FLOAT DOUBLE CONST VOLATILE VOID
	%token STRUCT UNION ENUM ELLIPSIS

	%token CASE DEFAULT IF ELSE SWITCH WHILE DO FOR GOTO CONTINUE BREAK RETURN

	%start translation_unit



	%name myparser

	// class definition
	{
		// place any extra class members here
	}

	// constructor
	{
		// place any extra initialisation code here
	}

	// destructor
	{
		// place any extra cleanup code here
	}

	// attribute type
	%include {
	#ifndef YYSTYPE
	#define YYSTYPE int
	#endif
	}

	// place any declarations here

	// %token <ival> NUMBER


	%%

	/////////////////////////////////////////////////////////////////////////////
	// rules section

	// place your YACC rules here (there must be at least one)
	primary_exp
		: ID{
			$$ = new node();
			//printf("108 ");
			$$ -> length = 1;
			$$->name="primary_exp";
			$$->children=new node* [1];
			$$->children[0] = $1.ntnode;
			
			//traverse_vartable(s.size()-1);
			typenode* ptr = search($1.ntnode->name,s.size()-1);
			// cout<<"$1.ntnode->name:"<<$1.ntnode->name<<endl;
			// cout<<"---------"<<ptr->name<<endl;
			traverse(ptr);				
			if(ptr != NULL)
			{
				$$->type = *ptr;
			}
			var_name = $1.ntnode->name;
			$$->truelist= $1.ntnode->truelist;
			$$->falselist= $1.ntnode->falselist;
			$$->nextlist = $1.ntnode->nextlist;
		}
		| CONSTANT{
			$$ = new node();
			//printf("116 ");
			$$ -> length = 1;
			$$->name="constant";
			$$->children=new node* [1];
			$$->children[0] = $1.ntnode;

			$$->dvalue = $1.ntnode->dvalue;
			$$->type = *(new typenode("double", 8));
			// offset += $$->type.width;
			offset += 1;
			//gen(newlabel(), "DEC", $$->type.width, 0, $$->type.addr);
			//gen(newlabel(), "=#", $1.ntnode->dvalue, 0, $$->type.addr);
		}
		| STRING_LITERAL{
			$$ = new node();
			//printf("123 ");
			$$ -> length = 1;
			$$->name="primary_exp";
			$$->children=new node* [1];
			$$->children[0] = $1.ntnode;	
		}
		| '(' exp ')'{
			$$ = new node();
			//printf("130 ");
			$$ -> length = 3;
			$$->name="primary_exp";	
			s.pop_back();
			$$->truelist = $2->truelist;
			$$->falselist = $2->falselist;  
			$$->nextlist = $2->nextlist;
		}
		| TRUE {
			$$ = new node();
			//printf("125 ");
			$$->name="primary_exp";
			int nextinstr = newlabel();			
			$$->falselist->push_back(nextinstr);
            gen(nextinstr, "j");
		}
		| FALSE {
			$$ = new node();
			//printf("126 ");
			$$->name="primary_exp";
			int nextinstr = newlabel();
			$$->falselist->push_back(nextinstr);
            gen(nextinstr, "j");
		}

		;

		postfix_pre_exp//调用
		: postfix_exp '('{
			//printf("241");
			fun_name = var_name;
			// cout<<endl<<"-----------------"<<endl;
			// cout<<"241, fun_name:"<<fun_name<<endl;
		}
		;

	postfix_exp
		: primary_exp{
			$$ = new node();
			//printf("142 ");
			$$ -> length = 1;
			$$->name="postfix_exp";
			$$->children=new node* [1];
			$$->children[0] = $1;

			$$->dvalue = $1->dvalue;
			$$->type = $1->type;	
			$$->truelist= $1->truelist;
			$$->falselist= $1->falselist;
			$$->nextlist = $1->nextlist;
		}
		| postfix_exp '[' exp ']'{	
			$$ = new node();
			//printf("149 ");
			$$ -> length = 4;
			$$->name="postfix_exp";
			$$->children=new node* [4];
			$$->children[0] = $1;
			$$->children[1] = $2.ntnode;
			$$->children[2] = $3;
			$$->children[3] = $4.ntnode;
			$$->type = *($1->type.right);
			gen(newlabel(), "=#", 4, 0, offset);
			gen(newlabel(), "*", offset - 1, offset, offset + 1);
			offset++;
			gen(newlabel(), "array", 0, offset, offset + 1);
			// offset++;
		}
		| postfix_pre_exp ')'{
			$$ = new node();
			//printf("159 ");
			$$ -> length = 3;
			$$->name="call_fun";
			$$->children=new node* [3];
			typenode* temp = search(fun_name, s.size()-1);
			if(temp->right != NULL)
				$$ -> type = *(temp->right);
			else{
				temp = new typenode();
				$$->type = *temp;
			}
			s.pop_back();  
			if (temp->right->name != "void")
			{
				// cout << "PRINTPRINT" + temp->right->name;
				gen(newlabel(), "call", -1, 0, 0);
			}
			else gen(newlabel(), "call", 0, 0, 0);
			call_fun_addr = nextinstr;
		}
		| postfix_pre_exp argument_exp_list ')'{
			$$ = new node();
			//printf("168 ");
			$$ -> length = 4;
			$$->name="call_fun";
			s.pop_back();  
			call_fun_addr = nextinstr;
			vector<typenode*> v_argument_list_temp;
			typenode* type_exp = (search(fun_name, s.size()-1));
			// cout<<"----------->type_exp.name"<<type_exp->name<<endl;
			// cout<<"----------->type_exp->left.name"<<type_exp->left->name<<endl;
			traverse_argument(type_exp->left, v_argument_list_temp);
			for(int x=0;x<v_argument_list_temp.size();x++){
			}
			if (type_exp->right->name != "void")
			{
				// cout << "PRINTPRINT" + type_exp->right->name;
				gen(newlabel(), "call", -1, 0, 0);}
			else gen(newlabel(), "call", 0, 0, 0);
			// cout<<endl;
			// cout<<"parameter-------------------->"<<endl;
			for(int x=0;x<v_argument_list_temp.size();x++){
				cout<<v_argument_list_temp[x]->name<<" ";
			}
			cout<<endl;
			cout<<"argument-------------------->"<<endl;
			for(int x=0;x<v_argument_list.size();x++){
				cout<<v_argument_list[x]->name<<" ";
			}
			cout<<endl;
			int itm = 0;
			if(type_exp->name == "fun"){
				// cout<<"it is a function!!!"<<endl;
				if(v_argument_list.size()!=v_argument_list_temp.size()){
					cout<<endl<<"---------------------------------"<<endl;
					cout<<"|Argument_list doesn't matched!!|"<<endl;
					cout<<"--------------------------------"<<endl;
				}
				else{
					while(itm<v_argument_list.size()){
						if(check_type(v_argument_list[itm], v_argument_list_temp[itm]))
						{
							itm++;
						}
						else{
							cout<<endl<<"---------------------------------"<<endl;
							cout<<"|Argument_list doesn't matched!!|"<<endl;
							cout<<"----------------------------------"<<endl;
							break;
						}
					}
				}
				if(itm == v_argument_list.size()){
					// cout<<"-----------------------"<<endl;
					// cout<<"|Argument_list matched!|"<<endl;
					// cout<<"-----------------------"<<endl;
				}
				else{
					cout<<endl<<"----------------------------------"<<endl;
					cout<<"|Argument_list doesn't matched!!|"<<endl;
					cout<<"----------------------------------"<<endl;
				}
			}
			$$->type = *(type_exp->right);
			// cout<<"clear v_argument_list"<<endl;
			v_argument_list.clear();
		}
		| postfix_exp '.' ID{
			$$ = new node();
			//printf("178 ");
			$$ -> length = 3;
			$$->name="postfix_exp";
			$$->children=new node* [3];
			$$->children[0] = $1;
			$$->children[1] = $2.ntnode;
			$$->children[2] = $3.ntnode;

			if ($1->type.name == "record")
			{
				typenode pointer;
				pointer.name = "###";
				int temp_addr;
				search_struct(&($1->type), $3.ntnode->name, pointer, temp_addr);
				if (pointer.name == "###")
					cout << "struct doesn't have " << $3.ntnode->name << endl;
				else{
					// cout<<"struct has "<<$3.ntnode->name<<endl;
				}
				$$->type = pointer;
				$$->type.addr = $1->type.addr + temp_addr;
				// cout<<"struct has ";
			} 
			else if($1->type.name == "array" && $1->type.right->name == "record"){
				typenode pointer;
				pointer.name = "#O#O#O";
				int temp_addr;
				search_struct($1->type.right, $3.ntnode->name, pointer, temp_addr);
				if (pointer.name == "#O#O#O")
					cout << "struct doesn't have " << $3.ntnode->name << endl;
				else{
					// cout<<"struct has "<<$3.ntnode->name<<endl;
				}
				$$->type = pointer;
			}
			else cout << "struct doesn't exist!\n";

		
		}
		| postfix_exp PTR_OP ID{
			$$ = new node();
			//printf("187 ");
			$$ -> length = 3;
			$$->name="postfix_exp";
			$$->children=new node* [3];
			$$->children[0] = $1;
			$$->children[1] = $2.ntnode;
			$$->children[2] = $3.ntnode;
		}
		| postfix_exp INC_OP{
			$$ = new node();
			//printf("196 ");
			$$ -> length = 2;
			$$->name="postfix_exp";
			$$->children=new node* [2];
			$$->children[0] = $1;
			$$->children[1] = $2.ntnode;

			if(!isComputable($1->type.name)){
				cout<<endl<<"--------------------------------------------------------------"<<endl;
				cout<<"|No additive calculation can be made for uncalculable types!!|"<<endl;
				cout<<"--------------------------------------------------------------"<<endl;
			}
		}
		| postfix_exp DEC_OP{
			$$ = new node();
			//printf("204 ");
			$$ -> length = 2;
			$$->name="postfix_exp";
			$$->children=new node* [2];
			$$->children[0] = $1;
			$$->children[1] = $2.ntnode;

			if(!isComputable($1->type.name)){
				cout<<endl<<"------------------------------------------"<<endl;
				cout<<"|Can't subtract from uncalculable types!!|"<<endl;
				cout<<"------------------------------------------"<<endl;
			}
		}
		;

	argument_exp_list
		: assignment_exp{
			$$ = new node();
			//printf("215 ");
			$$ -> length = 1;
			$$->name="argument_exp_list";
			$$->children=new node* [1];
			$$->children[0] = $1;
			v_argument_list.push_back(&($1->type));
			gen(newlabel(), "ARG", 0, 0, $1->type.addr);
			$$->type = $1->type;						
		}
		| argument_exp_list ',' assignment_exp{
			$$ = new node();
			//printf("222 ");
			$$ -> length = 3;
			$$->name="argument_exp_list";
			$$->children=new node* [3];
			$$->children[0] = $1;
			$$->children[1] = $2.ntnode;
			$$->children[2] = $3;

			// v_argument_list.push_back($1->type.name);
			v_argument_list.push_back(&($3->type));
		}
		; 

	unary_exp
		: postfix_exp{
			$$ = new node();
			//printf("234 ");
			$$ -> length = 1;
			$$->name = $1->name;
			$$->children=new node* [1];
			$$->children[0] = $1;

			$$->dvalue = $1->dvalue;
			$$->type = $1->type;
			$$->truelist= $1->truelist;
			$$->falselist= $1->falselist;
			$$->nextlist = $1->nextlist;
		}
		| INC_OP unary_exp{
			$$ = new node();
			//printf("241 ");
			$$ -> length = 2;
			$$->name="unary_exp";
			$$->children=new node* [2];
			$$->children[0] = $1.ntnode;
			$$->children[1] = $2;

			if(!isComputable($2->type.name)){
				cout<<endl<<"-------------------------------------------------------------"<<endl;
				cout<<"|No additive calculation can be made for uncalculable types!!|"<<endl;
				cout<<"--------------------------------------------------------------"<<endl;
			}															
		}
		| DEC_OP unary_exp{
			$$ = new node();
			//printf("249 ");
			$$ -> length = 2;
			$$->name="unary_exp";
			$$->children=new node* [2];
			$$->children[0] = $1.ntnode;
			$$->children[1] = $2;

			if(!isComputable($2->type.name)){
				cout<<endl<<"------------------------------------------"<<endl;
				cout<<"|Can't subtract from uncalculable types!!|"<<endl;
				cout<<"------------------------------------------"<<endl;
			}
		}
		| unary_operator cast_exp{
			//cast_exp:单目表达式/强制类型转换
			$$ = new node();
			//printf("257 ");
			$$ -> length = 2;
			$$->name="unary_exp";
			if($1->name == "!") {
				$$->truelist = $2->falselist;
			    $$->falselist = $2->truelist;
			}
			if($1->name != "*" && $1->name != "&"){
				$$ -> type = $2->type;
			}
			else{
				$$ -> type.addr = offset;
				// offset += $$ -> type.width;
				offset += 1;
				//gen(newlabel(), "DEC", $$->type.width, 0, $$->type.addr);
				if ($1->name == "&") {
					gen(newlabel(), "=&", $2->type.addr, 0, $$ -> type.addr);
				}
				if ($1->name == "*") {
					gen(newlabel(), "=*", $2->type.addr, 0, $$ -> type.addr);
				}
			}
		}
		| SIZEOF unary_exp{
			$$ = new node();
			//printf("265 ");
			$$ -> length = 2;
			$$->name="unary_exp";
			$$->children=new node* [2];
			$$->children[0] = $1.ntnode;
			$$->children[1] = $2;

			if($2->type.width!=0)
			{
				$$->dvalue = $2->type.width; 
			}
			else 
			{	
				cout<<endl<<"---------------------------------------------------"<<endl;
				cout<<"|Unknown type, unable to perform sizeof operation!!|"<<endl;
				cout<<"---------------------------------------------------"<<endl;
			}
		}
		| SIZEOF '(' type_name ')'{
			$$ = new node();
			//printf("273 ");
			$$ -> length = 4;
			$$->name="unary_exp";
			$$->children=new node* [4];
			$$->children[0] = $1.ntnode;
			$$->children[1] = $2.ntnode;
			$$->children[2] = $3;
			$$->children[3] = $4.ntnode;
			s.pop_back();  

			if($3->type.width!=0)$$->dvalue = $3->type.width;
			else cout<<"!Unknown type, unable to perform sizeof operation!||"<<endl;
		}
		;

	unary_operator
		: '&'{
			$$ = new node();
			//printf("286 ");
			$$->name="&";
		}
		| '*'{
			$$ = new node();
			//printf("293 ");
			$$->name="*";
		}
		| '+'{
			$$ = new node();
			//printf("301 ");
			$$->name="+";
		}
		| '-'{
			$$ = new node();
			//printf("308 ");
			$$->name="-";
		}
		| '~'{
			$$ = new node();
			//printf("315 ");
			$$->name="~";
		}
		| '!'{
			$$ = new node();
			//printf("322 ");
			$$->name="!";
		}
		;

	cast_exp
		: unary_exp{
			$$ = new node();
			//printf("332 ");
			$$ -> length = 1;
			$$->name = $1->name;
			$$->children=new node* [1];
			$$->children[0] = $1;

			$$->dvalue = $1->dvalue;
			$$->type = $1->type;
			$$->truelist= $1->truelist;
			$$->falselist= $1->falselist;
			$$->nextlist = $1->nextlist;
		}
		| '(' type_name ')' cast_exp{
			$$ = new node();
			//printf("339 ");
			$$ -> length = 4;
			$$->name="cast_exp";
			$$->children=new node* [1];
			$$->children[0] = $1.ntnode;
			$$->children[1] = $2;
			$$->children[2] = $3.ntnode;
			$$->children[3] = $4;
			s.pop_back();  
		}
		;

	multiplicative_exp
		: cast_exp{
			$$ = new node();
			//printf("352 ");
			$$->name = $1->name;
			$$->dvalue = $1->dvalue;
			$$->type = $1->type;	
		    $$->truelist= $1->truelist;
			$$->falselist= $1->falselist;
			$$->nextlist = $1->nextlist;	
		}
		| multiplicative_exp '^' cast_exp{
			$$ = new node();
			//printf("354 ");
			$$ -> length = 3;
			$$->name="multiplicative_exp";
			$$->children=new node* [3];
			$$->children[0] = $1;
			$$->children[1] = $2.ntnode;
			$$->children[2] = $3;

			if (!isComputable($1->type.name) || !isComputable($3->type.name)){
				cout<<endl<<"--------------------------------------------------------"<<endl;
				cout<<"|Mismatch of Operator Types in Multiplication Operations!!|"<<endl;
				cout<<"----------------------------------------------------------"<<endl;
			}
			$$->type = $1->type;
			$$->type.addr = offset;
			//gen(newlabel(), "DEC", $$->type.width, 0, $$->type.addr);
			gen(newlabel(), "^", $1->type.addr, $3->type.addr, offset);
			// offset += max($1->type.width, $3->type.width);
			offset += 1;
												
		}
		| multiplicative_exp '*' cast_exp{
			$$ = new node();
			//printf("359 ");
			$$ -> length = 3;
			$$->name="multiplicative_exp";
			$$->children=new node* [3];
			$$->children[0] = $1;
			$$->children[1] = $2.ntnode;
			$$->children[2] = $3;

			if (!isComputable($1->type.name) || !isComputable($3->type.name)){
				cout<<endl<<"-----------------------------------------------------------"<<endl;
				cout<<"|Mismatch of Operator Types in Multiplication Operations!!|"<<endl;
				cout<<"-----------------------------------------------------------"<<endl;
			}
			$$->type = $1->type;
			$$->type.addr = offset;
			//gen(newlabel(), "DEC", $$->type.width, 0, $$->type.addr);
			gen(newlabel(), "*", $1->type.addr, $3->type.addr, offset);
			// offset += max($1->type.width, $3->type.width);
			offset += 1;
												
		}
		| multiplicative_exp '/' cast_exp{
			$$ = new node();
			//printf("368 ");
			$$ -> length = 3;
			$$->name="multiplicative_exp";
			$$->children=new node* [3];
			$$->children[0] = $1;
			$$->children[1] = $2.ntnode;
			$$->children[2] = $3;

			if (!isComputable($1->type.name) || !isComputable($3->type.name))
			{cout<<endl<<"------------------------------------------"<<endl;
				cout<<"|Divisional Operator Type Mismatch!!|"<<endl;
				cout<<"------------------------------------------"<<endl;
			}				
			$$->type = $1->type;
			$$->type.addr = offset;
			//gen(newlabel(), "DEC", $$->type.width, 0, $$->type.addr);
			gen(newlabel(), "/", $1->type.addr, $3->type.addr, offset);
			// offset += max($1->type.width, $3->type.width);
			offset += 1;
			
		}
		| multiplicative_exp '%' cast_exp{
			$$ = new node();
			//printf("377 ");
			$$ -> length = 3;
			$$->name="multiplicative_exp";
			$$->children=new node* [3];
			$$->children[0] = $1;
			$$->children[1] = $2.ntnode;
			$$->children[2] = $3;

			if (!isComputable($1->type.name) || isComputable($3->type.name))
			{cout<<endl<<"------------------------------------------"<<endl;
				cout<<"|Complementation Operator Type Mismatch!!|"<<endl;
				cout<<"------------------------------------------"<<endl;
			}
			$$->type = $1->type;
			$$->type.addr = offset;
			//gen(newlabel(), "DEC", $$->type.width, 0, $$->type.addr);
			gen(newlabel(), "%", $1->type.addr, $3->type.addr, offset);
			// offset += max($1->type.width, $3->type.width); 
			offset += 1;
		
		}
		;

	additive_exp
		: multiplicative_exp{
			$$ = new node();
			//printf("389 ");
			$$ -> length = 1;
            $$->name = $1->name;
			$$->children=new node* [1];
			$$->children[0] = $1;

			$$->dvalue = $1->dvalue;
			$$->type = $1->type;
			$$->truelist= $1->truelist;
			$$->falselist= $1->falselist;
			$$->nextlist = $1->nextlist;
		}
		| additive_exp '+' multiplicative_exp{
			$$ = new node();
			//printf("396 ");
			$$ -> length = 3;
			$$->name="additive_exp";
			if (!isComputable($1->type.name) || !isComputable($3->type.name))
			{cout<<endl<<"------------------------------------------"<<endl;
				cout<<"|Operator type r,  $4->type.addr>>mismatch!!|"<<endl;	
				cout<<"------------------------------------------"<<endl;}
				
			$$->type = $1->type;
			$$->type.addr = offset;
			//gen(newlabel(), "DEC", $$->type.width, 0, $$->type.addr);	
			gen(newlabel(), "+", $1->type.addr, $3->type.addr, offset);
			// offset += max($1->type.width, $3->type.width);
			offset += 1;
		}
		| additive_exp '-' multiplicative_exp{
			$$ = new node();
			//printf("405 ");
			$$ -> length = 3;
			$$->name="additive_exp";
			if (!isComputable($1->type.name) || isComputable($3->type.name)){
				cout<<endl<<"---------------------------"<<endl;			
				cout<<"|Operator type mismatch!!|"<<endl;
				cout<<"------------------------------------------"<<endl;
			}
					
			$$->type = $1->type;
			$$->type.addr = offset;
			//gen(newlabel(), "DEC", $$->type.width, 0, $$->type.addr);
			gen(newlabel(), "-", $1->type.addr, $3->type.addr, offset);
			// offset += max($1->type.width, $3->type.width);
			offset += 1;
		}
		;

	shift_exp
		: additive_exp{
			$$ = new node();
			//printf("417 ");
			$$ -> length = 1;
			$$->name = $1->name;
			$$->children=new node* [1];
			$$->children[0] = $1;

			$$->dvalue = $1->dvalue;
			$$->type = $1->type;
			$$->truelist= $1->truelist;
			$$->falselist= $1->falselist;
			$$->nextlist = $1->nextlist;
		}
		| shift_exp LEFT_OP additive_exp{
			$$ = new node();
			//printf("424 ");
			$$ -> length = 3;
			$$->name="shift_exp";
			$$->children=new node* [3];
			$$->children[0] = $1;
			$$->children[1] = $2.ntnode;
			$$->children[2] = $3;

			if (!isComputable($1->type.name) || !isComputable($3->type.name))
			{
				cout<<endl<<"-----------------------------------"<<endl;							
				cout<<"|Shift Operator Operator Mismatch!!|"<<endl;
				cout<<"-----------------------------------"<<endl;
			}
		}
		| shift_exp RIGHT_OP additive_exp{
			$$ = new node();
			//printf("433 ");
			$$ -> length = 3;
			$$->name="shift_exp";
			$$->children=new node* [3];
			$$->children[0] = $1;
			$$->children[1] = $2.ntnode;
			$$->children[2] = $3;

			if (!isComputable($1->type.name) || !isComputable($3->type.name))
			{
				cout<<endl<<"------------------------------------------"<<endl;
					cout<<"|Shift Operator Operator Mismatch!!|"<<endl;
					cout<<"------------------------------------------"<<endl;
			}
		}
		;

	relational_exp
		: shift_exp{
			$$ = new node();
			//printf("445 ");
			$$ -> length = 1;
			$$->name = $1->name;
			$$->children=new node* [1];
			$$->children[0] = $1;

			$$->dvalue = $1->dvalue;
			$$->type = $1->type;	
		    $$->truelist= $1->truelist;
			$$->falselist= $1->falselist;
			$$->nextlist = $1->nextlist;
		}
		| relational_exp '<' shift_exp{
			$$ = new node();
			//printf("452 ");
			$$ -> length = 3;
			$$->name="relational_exp";
			$$->children=new node* [3];
			$$->children[0] = $1;
			$$->children[1] = $2.ntnode;
			$$->children[2] = $3;

			if (!isComputable($1->type.name) || !isComputable($3->type.name))
			{		cout<<endl<<"------------------------------------------"<<endl;
					cout<<"|Relational expression type mismatch!!|"<<endl;
					cout<<"------------------------------------------"<<endl;
					}
			gen(newlabel(), "j<", $1->type.addr, $3->type.addr); 
			$$->truelist->push_back(nextinstr);
			$$->falselist->push_back(newlabel());
			gen(nextinstr, "j");
		}
		| relational_exp '>' shift_exp{
			$$ = new node();
			//printf("461 ");
			$$ -> length = 3;
			$$->name="relational_exp";

			if (!isComputable($1->type.name) || !isComputable($3->type.name))
			{cout<<endl<<"------------------------------------------"<<endl;
					cout<<"|Relational expression type mismatch!!|"<<endl;
					cout<<"------------------------------------------"<<endl;
			}
			gen(newlabel(), "j>", $1->type.addr, $3->type.addr); 
			$$->truelist->push_back(nextinstr); 
			$$->falselist->push_back(newlabel());
			gen(nextinstr, "j");
		}
		| relational_exp LE_OP shift_exp{
			$$ = new node();
			//printf("470 ");
			$$ -> length = 3;
			$$->name="relational_exp";
			$$->children=new node* [3];
			$$->children[0] = $1;
			$$->children[1] = $2.ntnode;
			$$->children[2] = $3;

			if (!isComputable($1->type.name) || !isComputable($3->type.name))
			{		cout<<endl<<"------------------------------------------"<<endl;
					cout<<"|Relational expression type mismatch!!|"<<endl;
					cout<<"------------------------------------------"<<endl;
			}					

			gen(newlabel(), "j>", $1->type.addr, $3->type.addr); 
			$$->falselist->push_back(nextinstr); 
			$$->truelist->push_back(newlabel());
			gen(nextinstr, "j"); 
		}
		| relational_exp GE_OP shift_exp{
			$$ = new node();
			//printf("479 ");
			$$ -> length = 3;
			$$->name="relational_exp";
			$$->children=new node* [3];
			$$->children[0] = $1;
			$$->children[1] = $2.ntnode;
			$$->children[2] = $3;

			if (!isComputable($1->type.name) || !isComputable($3->type.name))
			{
					cout<<"------------------------------------------"<<endl;			
					cout<<"|Relational expression type mismatch!!|"<<endl;
					cout<<"------------------------------------------"<<endl;
			}
			gen(newlabel(), "j<", $1->type.addr, $3->type.addr); 
			$$->falselist->push_back(nextinstr); 
			$$->truelist->push_back(newlabel());
			gen(nextinstr, "j");
		}
		;

	equality_exp
		: relational_exp{
			$$ = new node();
			//printf("491 ");
			$$ -> length = 1;
			$$->name = $1->name;
			$$->children=new node* [1];
			$$->children[0] = $1;

			$$->dvalue = $1->dvalue;
			$$->type = $1->type;
			$$->truelist= $1->truelist;
			$$->falselist= $1->falselist;
			$$->nextlist = $1->nextlist;
		}
		| equality_exp EQ_OP relational_exp{
			$$ = new node();
			//printf("498 ");
			$$ -> length = 3;
			$$->name="equality_exp";
			$$->children=new node* [3];
			$$->children[0] = $1;
			$$->children[1] = $2.ntnode;
			$$->children[2] = $3;
			$$->type=boolnode;

			if (!isComputable($1->type.name) || !isComputable($3->type.name))
			{cout<<endl<<"------------------------------------------"<<endl;
					cout<<"|Relational expression type mismatch!!|"<<endl;
					cout<<"------------------------------------------"<<endl;
					}
			gen(newlabel(), "j=", $1->type.addr, $3->type.addr);  
			$$->truelist->push_back(nextinstr);    
			$$->falselist->push_back(newlabel());       
			gen(nextinstr, "j"); 
		}
		| equality_exp NE_OP relational_exp{
			$$ = new node();
			//printf("507 ");
			$$ -> length = 3;
			$$->name="equality_exp";
			$$->children=new node* [3];
			$$->children[0] = $1;
			$$->children[1] = $2.ntnode;
			$$->children[2] = $3;
			$$->type=boolnode;

			if (!isComputable($1->type.name) || !isComputable($3->type.name))
			{cout<<"------------------------------------------"<<endl;
				cout<<"|Relational expression type mismatch!!|"<<endl;
				cout<<"------------------------------------------"<<endl;
			}
			
			int nextinstr = newlabel();
			gen(nextinstr, "j=", $1->type.addr, $3->type.addr);  
			$$->falselist->push_back(nextinstr); 
			nextinstr = newlabel();
			$$->truelist->push_back(nextinstr);    
			gen(nextinstr, "j"); 
		}
		;

	and_exp
		: equality_exp{
			$$ = new node();
			//printf("519 ");
			$$ -> length = 1;
			$$->name = $1->name;
			$$->children=new node* [1];
			$$->children[0] = $1;

			$$->dvalue = $1->dvalue;
			$$->type = $1->type;
			$$->truelist= $1->truelist;
			$$->falselist= $1->falselist;
			$$->nextlist = $1->nextlist;
		}
		| and_exp '&' equality_exp{
			$$ = new node();
			//printf("526 ");
			$$ -> length = 3;
			$$->name="and_exp";
			$$->children=new node* [3];
			$$->children[0] = $1;
			$$->children[1] = $2.ntnode;
			$$->children[2] = $3;
			$$->type=$3->type;

			if (!isInteger($1->type.name) || !isInteger($3->type.name))
{cout<<"------------------------------------------"<<endl;			
					cout<<"|Intersection Operator Type Mismatch!!|"<<endl;
cout<<"------------------------------------------"<<endl;}					
		}
		;

	exclusive_or_exp
		: and_exp{
			$$ = new node();
			//printf("538 ");
			$$ -> length = 1;
			$$->name = $1->name;
			$$->children=new node* [1];
			$$->children[0] = $1;

			$$->dvalue = $1->dvalue;
			$$->type = $1->type;
			$$->truelist= $1->truelist;
			$$->falselist= $1->falselist;
			$$->nextlist = $1->nextlist;
		}
		| exclusive_or_exp '^' and_exp{
			$$ = new node();
			//printf("545 ");
			$$ -> length = 3;
			$$->name="exclusive_or_exp";
			$$->children=new node* [3];
			$$->children[0] = $1;
			$$->children[1] = $2.ntnode;
			$$->children[2] = $3;
			$$->type=$3->type;

			if (!isInteger($1->type.name) || !isInteger($3->type.name))
			{cout<<"------------------------------------------"<<endl;
			cout<<"|Intersection Operator Type Mismatch!!|"<<endl;
			cout<<"------------------------------------------"<<endl;}
					
		}
		;

	inclusive_or_exp
		: exclusive_or_exp{
			$$ = new node();
			//printf("557 ");
			$$ -> length = 1;
			$$->name = $1->name;
			$$->children=new node* [1];
			$$->children[0] = $1;

			$$->dvalue = $1->dvalue;
			$$->type = $1->type;
			$$->truelist= $1->truelist;
			$$->falselist= $1->falselist;
			$$->nextlist = $1->nextlist;
		}
		| inclusive_or_exp '|' exclusive_or_exp{
			$$ = new node();
			//printf("564 ");
			$$ -> length = 3;
			$$->name="inclusive_or_exp";
			$$->children=new node* [3];
			$$->children[0] = $1;
			$$->children[1] = $2.ntnode;
			$$->children[2] = $3;
			$$->type=$3->type;

			if (!isInteger($1->type.name) || !isInteger($3->type.name))
			{cout<<"------------------------------------------"<<endl;
			cout<<"|Or operation left-right operand type mismatch!!| "<<endl;
			cout<<"------------------------------------------"<<endl;}
					
		}
		;

	logical_and_exp
		: inclusive_or_exp{
			$$ = new node();
			//printf("576 ");
			$$ -> length = 1;
			$$->name = $1->name;
			$$->children=new node* [1];
			$$->children[0] = $1;

			$$->dvalue = $1->dvalue;
			$$->type = $1->type;
			$$->truelist= $1->truelist;
			$$->falselist= $1->falselist;
			$$->nextlist = $1->nextlist;
		}
		| logical_and_exp AND_OP M inclusive_or_exp{
			$$ = new node();
			//printf("583 ");
			$$ -> length = 3;
			$$->name="logical_and_exp";
			$$->children=new node* [3];
			$$->children[0] = $1;
			$$->children[1] = $2.ntnode;
			$$->children[2] = $3;
			$$->type=boolnode;

			backpatch($1->truelist, $3->instr);
			$$->truelist = $4->truelist;
			$$->falselist = merge($1->falselist, $4->falselist); 		
		}
		;
	M
		: {
			$$ = new node();
			//printf("584 ");
			$$->name="M";
			$$->instr = nextinstr + 1;
		}
		;

	N
		: {
			$$ = new node();
			//printf("585 ");
			$$->nextlist->push_back(nextinstr + 1);
			gen(nextinstr+1, "j");
		}
		;
	P
		: {
			$$ = new node();
			//printf("586 ");
			$$->nextlist->push_back(newlabel());
			gen(nextinstr, "j");
		}
		;


	logical_or_exp
		: logical_and_exp{
			$$ = new node();
			//printf("595 ");
			$$ -> length = 1;
			$$->name = $1->name;
			$$->children=new node* [1];
			$$->children[0] = $1;

			$$->dvalue = $1->dvalue;
			$$->type = $1->type;

			$$->truelist= $1->truelist;
			$$->falselist= $1->falselist;
			$$->nextlist = $1->nextlist;
		}
		| logical_or_exp OR_OP M logical_and_exp{
			$$ = new node();
			//printf("602 ");
			$$ -> length = 3;
			$$->name="logical_or_exp";
			$$->type=boolnode;
			backpatch($1->falselist, $3->instr);
			$$->truelist = merge($1->truelist, $4->truelist);
			$$->falselist= $4->falselist;
		}
		;

	conditional_exp
		: logical_or_exp{
			$$ = new node();
			//printf("614 ");
			$$ -> length = 1;
			$$->name = $1->name;	
			$$->children=new node* [1];
			$$->children[0] = $1;	

			$$->dvalue = $1->dvalue;	
			$$->type = $1->type;
			$$->truelist= $1->truelist;
			$$->falselist= $1->falselist;
			$$->nextlist = $1->nextlist;
			 
		}
		| logical_or_exp '?' exp ':' conditional_exp{
			$$ = new node();
			//printf("621 ");
			$$ -> length = 5;
			$$->name="conditional_exp";
			$$->type=$3->type;

			vector<string> v1;
			vector<string> v2;
			compare_traverse(&$3->type, v1);
			compare_traverse(&$5->type, v2);
			if (v1 == v2){
				// cout<<"------\n";
				// cout<<"|match|\n";
				// cout<<"------\n";
			}	
			else{
				cout<<"-----------------"<<endl;
				cout<<"|type mismatch!!|"<<endl;
				cout<<"-----------------"<<endl;
			}			
		}
		;

	assignment_exp
		: conditional_exp{
			//(1)谓词表达式
			//(2)条件表达式 a<b?a:b
			$$ = new node();
			//printf("635 ");
			$$ -> length = 1;
			$$->name = $1->name;
			$$->type = $1->type;
			//(1)???????
			//(2)???????? a<b?a:b
			$$->truelist= $1->truelist;
			$$->falselist= $1->falselist;
			$$->nextlist = $1->nextlist;
		}
		| unary_exp assignment_operator assignment_exp{
			$$ = new node();
			//printf("642 ");
			$$ -> length = 3;
			$$->name="assignment_exp";
			  
			$$->type = $3->type;
			if (check_type(&$1->type, &$3->type)){
				// cout<<"----------------"<<endl;
				// cout<<"|Two sides equal|"<<endl;
				// cout<<"----------------"<<endl;
			}	
			else{
				cout<<"-------------------------"<<endl;
				cout<<"| two sides don't match!!|"<<endl;
				cout<<"-------------------------"<<endl;
			}
			gen(newlabel(), $2->name, $1->type.addr, $3->type.addr, $1->type.addr);

			}
		;

	assignment_operator
		: '='{
			$$ = new node();
			//printf("654 ");
			$$ -> length = 1;
			$$->name="=";
			$$->children=new node* [1];
			$$->children[0] = $1.ntnode;		
		}
		| MUL_ASSIGN{
			$$ = new node();
			//printf("661 ");
			$$ -> length = 1;
			$$->name="*=";
			$$->children=new node* [1];
			$$->children[0] = $1.ntnode;		
		}
		| DIV_ASSIGN{
			$$ = new node();
			//printf("668 ");
			$$ -> length = 1;
			$$->name="/=";
			$$->children=new node* [1];
			$$->children[0] = $1.ntnode;		
		}
		| MOD_ASSIGN{
			$$ = new node();
			//printf("675 ");
			$$ -> length = 1;
			$$->name="%=";
			$$->children=new node* [1];
			$$->children[0] = $1.ntnode;		
		}
		| ADD_ASSIGN{
			$$ = new node();
			//printf("682 ");
			$$ -> length = 1;
			$$->name="+=";
			$$->children=new node* [1];
			$$->children[0] = $1.ntnode;		
		}
		| SUB_ASSIGN{
			$$ = new node();
			//printf("689 ");
			$$ -> length = 1;
			$$->name="-=";
			$$->children=new node* [1];
			$$->children[0] = $1.ntnode;		
		}
		| LEFT_ASSIGN{
			$$ = new node();
			//printf("696 ");
			$$ -> length = 1;
			$$->name="<<=";
			$$->children=new node* [1];
			$$->children[0] = $1.ntnode;		
		}
		| RIGHT_ASSIGN{
			$$ = new node();
			//printf("703 ");
			$$ -> length = 1;
			$$->name=">>=";
			$$->children=new node* [1];
			$$->children[0] = $1.ntnode;		
		}
		| AND_ASSIGN{
			$$ = new node();
			//printf("710 ");
			$$ -> length = 1;
			$$->name="&=";
			$$->children=new node* [1];
			$$->children[0] = $1.ntnode;		
		}
		| XOR_ASSIGN{
			$$ = new node();
			//printf("717 ");
			$$ -> length = 1;
			$$->name="^=";
			$$->children=new node* [1];
			$$->children[0] = $1.ntnode;		
		}
		| OR_ASSIGN{
			$$ = new node();
			//printf("724 ");
			$$ -> length = 1;
			$$->name="|=";
			$$->children=new node* [1];
			$$->children[0] = $1.ntnode;		
		} 
		;

	exp
		: assignment_exp{
			$$ = new node();
			//printf("740 ");
			$$ -> length = 1;
			$$->name = $1->name;
			$$->children=new node* [1];
			$$->children[0] = $1;
			$$->type=$1->type;
			$$->truelist= $1->truelist;
			$$->falselist= $1->falselist;
			$$->nextlist = $1->nextlist;
		}
		| exp ',' assignment_exp{
			$$ = new node();
			//printf("741 ");
			$$ -> length = 3;
			$$->name="exp";
			$$->children=new node* [3];
			$$->children[0] = $1;
			$$->children[1] = $2.ntnode;
			$$->children[2] = $3;
			$$->type=$3->type;
			
			gen(newlabel(), ",", $1->instr, $3->instr, $3->type.addr);
		}
		;

	constant_exp
		: conditional_exp{
			$$ = new node();
			//printf("753 ");
			$$ -> length = 1;
			$$->name="constant_exp";
			$$->children=new node* [1];
			$$->children[0] = $1;		

			$$->dvalue = $1->dvalue;
		}
		;

	declaration
		: declaration_specifiers ';'{
			$$ = new node();
			//printf("763 ");
			$$ -> length = 2;
			$$->name="declaration";
			$$->children=new node* [2];
			$$->children[0] = $1;
			$$->children[1] = $2.ntnode;	
		}
		| declaration_specifiers init_declarator_list ';'{
			$$ = new node();
			//printf("771 ");
			$$ -> length = 3;
			$$->name="declaration";
			$$->children=new node* [3];
			$$->children[0] = $1;
			$$->children[1] = $2;
			$$->children[2] = $3.ntnode;

			$$->type = $1->type;		
		}
		// | ID ID ';'{
		// 	//printf("772");
		// }
		;

	declaration_specifiers
		: storage_class_specifier{ //static
			$$ = new node();
			//printf("783 ");
			$$ -> length = 1;
			$$->name="declaration_specifiers";
			$$->children=new node* [1];
			$$->children[0] = $1;
			$$->type=$1->type;
		}
		| storage_class_specifier declaration_specifiers //extern static
		{
			$$ = new node();
			//printf("791 ");
			$$ -> length = 2;
			$$->name="declaration_specifiers";
			$$->children=new node* [2];
			$$->children[0] = $1;
			$$->children[1] = $2;	
			$$->type=$1->type;	
		}
		| type_specifier{ // int
			$$ = new node();
			//printf("799 ");
			$$ -> length = 1;
			$$->name="declaration_specifiers";
			$$->children=new node* [1];
			$$->children[0] = $1;
			$$->type=*rFlag();
			// cout<<"[799: $$->type:]"<<$$->type.name<<endl;
		}
		| type_specifier declaration_specifiers{ // lont int
			$$ = new node();
			//printf("806 ");
			$$ -> length = 2;
			$$->name="declaration_specifiers";
			$$->children=new node* [2];
			$$->children[0] = $1;
			$$->children[1] = $2;
			$$->type=$1->type;	
		}
		| type_qualifier{ //const
			$$ = new node();
			//printf("814 ");
			$$ -> length = 1;
			$$->name="declaration_specifiers";
			$$->children=new node* [1];
			$$->children[0] = $1;
			$$->type=$1->type;	
		}
		| type_qualifier declaration_specifiers{ //const int
			$$ = new node();
			//printf("821 ");
			$$ -> length = 2;
			$$->name="declaration_specifiers";
			$$->children=new node* [2];
			$$->children[0] = $1;
			$$->children[1] = $2;
			$$->type=$1->type;	
		}
		;

	init_declarator_list
		: init_declarator{
			$$ = new node();
			//printf("832 ");
			$$ -> length = 1;
			$$->name="init_declarator_list";
			$$->children=new node* [1];
			$$->children[0] = $1;

			$$->type = $1->type;	
		}
		| init_declarator_list ',' init_declarator{
			$$ = new node();
			//printf("839 ");
			$$ -> length = 3;
			$$->name="init_declarator_list";
			$$->children=new node* [3];
			$$->children[0] = $1;
			$$->children[1] = $2.ntnode;
			$$->children[2] = $3;		
		}
		;

	init_declarator
		: declarator{
			$$ = new node();
			//printf("851 ");
			$$ -> length = 1;
			$$->name="init_declarator";
			$$->children=new node* [1];
			$$->children[0] = $1;		
		}
		| declarator '=' initializer{
			$$ = new node();
			//printf("858 ");
			$$ -> length = 3;
			$$->name="init_declarator";
			$$->children=new node* [3];
			$$->children[0] = $1;
			$$->children[1] = $2.ntnode;
			$$->children[2] = $3;

			if ($3 -> name == "call_fun") {
				code[call_fun_addr][1] = "1"; 								
			}

			traverse_vartable(s.size()-1);
			$$->type = $1->type;
			vector<string> v1;
			vector<string> v2;
			compare_traverse(&($1->type), v1);
			compare_traverse(&($3->type), v2);
			show_string(v1);
			show_string(v2);
			// cout<<"*************858$3->type.name"<<$3->type.name<<endl;
			// cout<<"*************858$1->type.name"<<$1->type.name<<endl;
			if (check_type(&($1->type), &($3->type))){
				// cout<<"--------"<<endl;
				// cout<<"|match!|"<<endl;
				// cout<<"--------"<<endl;
			}
			else{
				// cout<<"-----"<<$1->type.name<<"------"<<endl;
				cout<<endl<<"-----------------"<<endl;
				cout<<"|" + $1->type.name + " cannot match " + $3->type.name + "!!|"<<endl;
				// cout<<"-----"<<$3->type.name<<"------"<<endl;
				cout<<"-----------------"<<endl;
			}
			gen(newlabel(), "=", $1->type.addr, $3->type.addr, $1->type.addr);
		}
		;

	storage_class_specifier
		: TYPEDEF{
			$$ = new node();
			//printf("870 ");
			$$ -> length = 1;
			$$->name="storage_class_specifier";
			$$->children=new node* [1];
			$$->children[0] = $1.ntnode;			
		}
		| EXTERN{
			$$ = new node();
			//printf("877 ");
			$$ -> length = 1;
			$$->name="storage_class_specifier";
			$$->children=new node* [1];
			$$->children[0] = $1.ntnode;
		}
		| STATIC{
			$$ = new node();
			//printf("884 ");
			$$ -> length = 1;
			$$->name="storage_class_specifier";
			$$->children=new node* [1];
			$$->children[0] = $1.ntnode;
		}
		| AUTO{
			$$ = new node();
			//printf("891 ");
			$$ -> length = 1;
			$$->name="storage_class_specifier";
			$$->children=new node* [1];
			$$->children[0] = $1.ntnode;
		}
		| REGISTER{
			$$ = new node();
			//printf("898 ");
			$$ -> length = 1;
			$$->name="storage_class_specifier";
			$$->children=new node* [1];
			$$->children[0] = $1.ntnode;	
		}
		;

	type_specifier
		: VOID{
			$$ = new node();
			//printf("908 ");
			$$ -> length = 1;
			$$->name="type_specifier";
			$$->children=new node* [1];
			$$->children[0] = $1.ntnode;
			wFlag(voidnode);
			$$->type=voidnode;
		}
		| CHAR{
			$$ = new node();
			//printf("915 ");
			$$ -> length = 1;
			$$->name="type_specifier";
			$$->children=new node* [1];
			$$->children[0] = $1.ntnode;	
			wFlag(charnode);
			$$->type=charnode;
		}
		| SHORT{
			$$ = new node();
			//printf("922 ");
			$$ -> length = 1;
			$$->name="type_specifier";
			$$->children=new node* [1];
			$$->children[0] = $1.ntnode;		
			wFlag(shortnode);
			$$->type=shortnode;
		}
		| INT{
			$$ = new node();
			//printf("929 ");
			$$ -> length = 1;
			$$->name="type_specifier";
			$$->children=new node* [1];
			$$->children[0] = $1.ntnode;	
			wFlag(intnode);
			$$->type=intnode;
		}
		| LONG{
			$$ = new node();
			//printf("936 ");
			$$ -> length = 1;
			$$->name="type_specifier";
			$$->children=new node* [1];
			$$->children[0] = $1.ntnode;		
			wFlag(longnode);
			$$->type=longnode;
		}
		| FLOAT{
			$$ = new node();
			//printf("943 ");
			$$ -> length = 1;
			$$->name="type_specifier";
			$$->children=new node* [1];
			$$->children[0] = $1.ntnode;	
			wFlag(floatnode);
			$$->type=floatnode;
		}
		| DOUBLE{
			$$ = new node();
			//printf("950 ");
			$$ -> length = 1;
			$$->name="type_specifier";
			$$->children=new node* [1];
			$$->children[0] = $1.ntnode;	
			wFlag(doublenode);
			$$->type=doublenode;
		}
		| SIGNED{
			$$ = new node();
			//printf("957 ");
			$$ -> length = 1;
			$$->name="type_specifier";
			$$->children=new node* [1];
			$$->children[0] = $1.ntnode;		
			wFlag(signednode);
			$$->type=signednode;
		}
		| UNSIGNED{
			$$ = new node();
			//printf("964 ");
			$$ -> length = 1;
			$$->name="type_specifier";
			$$->children=new node* [1];
			$$->children[0] = $1.ntnode;		
			wFlag(unsignednode);
			$$->type=unsignednode;
		}
		| struct_or_union_specifier{
			$$ = new node();
			//printf("971 ");
			$$ -> length = 1;
			$$->name="type_specifier";
			$$->children=new node* [1];
			$$->children[0] = $1;

			wFlag($1->type);
			$$ -> type = $1 -> type;

		}
		| enum_specifier{
			$$ = new node();
			//printf("978 ");
			$$ -> length = 1;
			$$->name="type_specifier";
			$$->children=new node* [1];
			$$->children[0] = $1;		
		}
		| TYPE_NAME{
			$$ = new node();
			//printf("985 ");
			$$ -> length = 1;
			$$->name="type_specifier";
			$$->children=new node* [1];
			$$->children[0] = $1.ntnode;		
		}
		| type_specifier pointer{
		}
		;

	struct_or_union_def
		: struct_or_union ID '{' declaration_list '}' {
			$$ = new node();
			//printf("986 ");
			wFlag(*(create_struct($2.ntnode->name)));
		}
		|
		struct_or_union '{' declaration_list '}' {
			static int i = 1;
			$$ = new node();
			//printf("987 ");
			wFlag(*(create_struct("struct" + to_string(i))));
			s.back()->vartable["struct" + to_string(i++)] = rFlag();
		}
		;
		def_concat
		:';'{
			$$ = new node();
			//printf("988 ");
		}
		| init_declarator_list ';'{
			$$ = new node();
			//printf("989 ");
		}
		;
	struct_or_union_specifier
		: struct_or_union_def def_concat {
			$$ = new node();
			//printf("990 ");
		}
		| struct_or_union ID {
			$$ = new node();
			//printf("991 ");
			
			map<string, typenode*>::iterator i;
			if ((i = auto_define_type.find($2.ntnode->name)) != auto_define_type.end())
			{
				$$->type = *auto_define_type[$2.ntnode->name];
			}
			else cout << "struct doesn't exist!\n";
		}
		;

	/* struct_or_union_specifier
		: struct_or_union ID '{' declaration_list '}' ';' {  //struct a { int a = 0;};
			$$ = new node();
			//printf("995 ");
			$$ -> length = 6;
			$$->name="struct_or_union_specifier";
			$$->children=new node* [6];
			$$->children[0] = $1;
			$$->children[1] = $2.ntnode;
			$$->children[2] = $3.ntnode;
			$$->children[3] = $4;
			$$->children[4] = $5.ntnode;		
			$$->children[5] = $6.ntnode;
			
			create_struct($2.ntnode->name);
		}
		| struct_or_union ID '{' declaration_list '}' init_declarator_list ';' { // match!
			$$ = new node();
			//printf("1006 ");
			$$ -> length = 7;
			$$->name="struct_or_union_specifier";
			$$->children=new node* [7];
			$$->children[0] = $1;
			$$->children[1] = $2.ntnode;
			$$->children[2] = $3.ntnode;		
			$$->children[3] = $4;
			$$->children[4] = $5.ntnode;
			$$->children[5] = $6;
			$$->children[6] = $7.ntnode;

			create_struct($2.ntnode->name);
		}
		| struct_or_union '{' declaration_list '}' ';' { // struct a {int a = 0;};
			$$ = new node();
			//printf("1007 ");
			$$ -> length = 5;
			$$->name="struct_or_union_specifier";
			$$->children=new node* [5];
			$$->children[0] = $1;
			$$->children[1] = $2.ntnode;
			$$->children[2] = $3;
			$$->children[3] = $4.ntnode;
			$$->children[4] = $5.ntnode;
		}
		| struct_or_union '{' declaration_list '}' init_declarator_list ';' { //struct {int a = 0;}a[2];
			$$ = new node();
			//printf("1008 ");
			$$ -> length = 6;
			$$->name="struct_or_union_specifier";
			$$->children=new node* [6];
			$$->children[0] = $1;
			$$->children[1] = $2.ntnode;
			$$->children[2] = $3;
			$$->children[3] = $4.ntnode;
			$$->children[4] = $5;
			$$->children[5] = $6.ntnode;
		}
		| struct_or_union ID { // struct a
			$$ = new node();
			//printf("1016 ");
			$$ -> length = 2;
			$$->name="struct_or_union_specifier";
			$$->children=new node* [2];
			$$->children[0] = $1;
			$$->children[1] = $2.ntnode;	

			map<string, typenode*>::iterator i;
			if ((i = auto_define_type.find($2.ntnode->name)) != auto_define_type.end())
			{
				$$->type = *auto_define_type[$2.ntnode->name];
			}
			else cout << "struct doesn't exist!\n";
		}
		; */

	struct_or_union
		: STRUCT{
			$$ = new node();
			//printf("1027 ");
			$$ -> length = 1;
			$$->name="struct_or_union";
			$$->children=new node* [1];
			$$->children[0] = $1.ntnode;	
		}
		| UNION{
			$$ = new node();
			//printf("1034 ");
			$$ -> length = 1;
			$$->name="struct_or_union";
			$$->children=new node* [1];
			$$->children[0] = $1.ntnode;	
		}
		;

	struct_declaration_list
		: struct_declaration{
			$$ = new node();
			//printf("1044 ");
			$$ -> length = 1;
			$$->name="struct_declaration_list";
			$$->children=new node* [1];
			$$->children[0] = $1;	
		}
		| struct_declaration_list struct_declaration{
			$$ = new node();
			//printf("1051 ");
			$$ -> length = 2;
			$$->name="struct_declaration_list";
			$$->children=new node* [2];
			$$->children[0] = $1;
			$$->children[1] = $2;		
		}
		;

	struct_declaration
		: specifier_qualifier_list struct_declarator_list ';' {
			$$ = new node();
			//printf("1062 ");
			$$ -> length = 3;
			$$->name="struct_declaration";
			$$->children=new node* [3];
			$$->children[0] = $1;
			$$->children[1] = $2;
			$$->children[2] = $3.ntnode;
		}
		| assignment_exp struct_declarator_list ';' {
			$$ = new node();
			//printf("1062 ");
			$$ -> length = 3;
			$$->name="struct_declaration";
			$$->children=new node* [3];
			$$->children[0] = $1;
			$$->children[1] = $2;
			$$->children[2] = $3.ntnode;
		}
		;

	specifier_qualifier_list
		: type_specifier specifier_qualifier_list{
			$$ = new node();
			//printf("1074 ");
			$$ -> length = 2;
			$$->name="specifier_qualifier_list";
			$$->children=new node* [2];
			$$->children[0] = $1;
			$$->children[1] = $2;
		}
		| type_specifier{
			$$ = new node();
			//printf("1082 ");
			$$ -> length = 1;
			$$->name="specifier_qualifier_list";
			$$->children=new node* [1];
			$$->children[0] = $1;
		}
		| type_qualifier specifier_qualifier_list{
			$$ = new node();
			//printf("1089 ");
			$$ -> length = 2;
			$$->name="specifier_qualifier_list";
			$$->children=new node* [2];
			$$->children[0] = $1;
			$$->children[1] = $2;
		}
		| type_qualifier{
			$$ = new node();
			//printf("1097 ");
			$$ -> length = 1;
			$$->name="specifier_qualifier_list";
			$$->children=new node* [1];
			$$->children[0] = $1;
		}
		;

	struct_declarator_list
		: struct_declarator{
			$$ = new node();
			//printf("1107 ");
			$$ -> length = 1;
			$$->name="struct_declarator_list";
			$$->children=new node* [1];
			$$->children[0] = $1;
		}
		| struct_declarator_list ',' struct_declarator{
			$$ = new node();
			//printf("1114 ");
			$$ -> length = 3;
			$$->name="struct_declarator_list";
			$$->children=new node* [3];
			$$->children[0] = $1;
			$$->children[1] = $2.ntnode;
			$$->children[2] = $3;
		}
		;

	struct_declarator
		: declarator{
			$$ = new node();
			//printf("1126 ");
			$$ -> length = 1;
			$$->name="struct_declarator";
			$$->children=new node* [1];
			$$->children[0] = $1;
		}
		| ':' constant_exp{
			$$ = new node();
			//printf("1133 ");
			$$ -> length = 2;
			$$->name="struct_declarator";
			$$->children=new node* [2];
			$$->children[0] = $1.ntnode;
			$$->children[1] = $2;
		}
		| declarator ':' constant_exp{
			$$ = new node();
			//printf("1141 ");
			$$ -> length = 3;
			$$->name="struct_declarator";
			$$->children=new node* [3];
			$$->children[0] = $1;
			$$->children[1] = $2.ntnode;
			$$->children[2] = $3;
		}
		;

	enum_specifier
		: ENUM '{' enumerator_list '}' { //enum {a=1,b}
			$$ = new node();
			//printf("1153 ");
			$$ -> length = 4;
			$$->name="enum_specifier";
			$$->children=new node* [4];
			$$->children[0] = $1.ntnode;
			$$->children[1] = $2.ntnode;
			$$->children[2] = $3;
			$$->children[3] = $4.ntnode;
		}
		| ENUM ID '{' enumerator_list '}' { //enum q{a,b}
			$$ = new node();
			//printf("1163 ");
			$$ -> length = 5;
			$$->name="enum_specifier";
			$$->children=new node* [5];
			$$->children[0] = $1.ntnode;
			$$->children[1] = $2.ntnode;
			$$->children[2] = $3.ntnode;
			$$->children[3] = $4;
			$$->children[4] = $5.ntnode;
		}
		| ENUM ID {
			$$ = new node();
			//printf("1174 ");
			$$ -> length = 2;
			$$->name="enum_specifier";
			$$->children=new node* [2];
			$$->children[0] = $1.ntnode;
			$$->children[1] = $2.ntnode;
		}
		;

	enumerator_list
		: enumerator{
			$$ = new node();
			//printf("1185 ");
			$$ -> length = 1;
			$$->name="enumerator_list";
			$$->children=new node* [1];
			$$->children[0] = $1;
		}
		| enumerator_list ',' enumerator{
			$$ = new node();
			//printf("1192 ");
			$$ -> length = 3;
			$$->name="enumerator_list";
		}
		;

	enumerator
		: ID{
			$$ = new node();
			//printf("1204 ");
			$$ -> length = 1;
			$$->name="enumerator";
			$$->children=new node* [1];
			$$->children[0] = $1.ntnode;
		}
		| ID '=' constant_exp{
			$$ = new node();
			//printf("1211 ");
			$$ -> length = 3;
			$$->name="enumerator";
			$$->children=new node* [3];
			$$->children[0] = $1.ntnode;
			$$->children[1] = $2.ntnode;
			$$->children[2] = $3;
		}
		;

	type_qualifier
		: CONST{
			$$ = new node();
			//printf("1223 ");
			$$ -> length = 1;
			$$->name="type_qualifier";
			$$->children=new node* [1];
			$$->children[0] = $1.ntnode;
		}
		| VOLATILE{
			$$ = new node();
			//printf("1230 ");
			$$ -> length = 1;
			$$->name="type_qualifier";
			$$->children=new node* [1];
			$$->children[0] = $1.ntnode;
		}
		;

	declarator
		: pointer direct_declarator{
			$$ = new node();
			//printf("1240 ");
			$$ -> length = 2;
			$$->name="declarator";
		}
		| direct_declarator{
			$$ = new node();
			//printf("1248 ");
			$$ -> length = 1;
			$$->name="declarator";
			$$->children=new node* [1];
			$$->children[0] = $1;
			$$->type = $1->type;
		}
		;
	direct_pre_declarator
		: direct_declarator '('{
			//printf("8521");
			fun_name2 = var_name;
			// cout<<endl<<"-------------------"<<endl;
			// cout<<"8521 fun_name2:"<<fun_name2<<endl;
			fun_addr = $1->type.addr;
		}
		;

	direct_declarator
		: ID{
			$$ = new node();
			//printf("1258 ");
			$$ -> length = 1;
			$$->name="direct_declarator";
			var_name = $1.ntnode->name;
			//gen(newlabel(), "DEC", $1.ntnode->type.width, 0, $1.ntnode->type.addr);
			//cout << $1.ntnode->name << rFlag()->width << endl;
			$$->type = *rFlag();
			int temp = $1.ntnode->type.addr;
			$1.ntnode->type = *rFlag();
			$1.ntnode->type.addr = temp;
			s.back()->vartable[$1.ntnode->name] = rFlag();
		    var_set.insert($1.ntnode->type.addr);
			// offset += rFlag()->width;
			offset += 1;
			//gen(newlabel(), "DEC", $1.ntnode->type.width, 0, $1.ntnode->type.addr);
		}
		| '(' declarator ')' {
			$$ = new node();
			//printf("1265 ");
			$$ -> length = 3;
			$$->name="direct_declarator";
			$$->children=new node* [3];
			$$->children[0] = $1.ntnode;
			$$->children[1] = $2;
			$$->children[2] = $3.ntnode;
			$$->type = *rFlag();
			s.pop_back();  
		}
		| direct_declarator '[' constant_exp ']' {
			$$ = new node();
			//printf("1274 ");
			$$ -> length = 4;
			$$->name="direct_declarator";
			$$->children=new node* [4];
			$$->children[0] = $1;
			$$->children[1] = $2.ntnode;
			$$->children[2] = $3;
			$$->children[3] = $4.ntnode;

			typenode* root = rFlag();
			typenode* basetype = root;
			typenode* parent = root;		
			while(basetype->right != NULL) {
				parent = basetype;						
				basetype = basetype->right;
			}
			typenode* temp = new typenode("array");	
			char num[25];
			_itoa_s(int($3->dvalue), num, 10);
			root->width = root->width *= $3->dvalue;
			temp -> left = new typenode(string(num));
			temp -> right = basetype;
			if(root->right != NULL){
				parent -> right = temp;
			}
			else 
				root = temp;
			wFlag(*root);
			int tmp = $1->type.addr;
			rFlag()->addr = tmp;
			s.back()->vartable[var_name] = rFlag();
			// var_set.insert(var_name);
			$$->type = *rFlag();
			$1->type = *rFlag();
			// offset += rFlag()->width;
			offset += 1;
			gen(newlabel(), "=#", 4, 0, offset - 1);
			gen(newlabel(), "*", offset - 1, offset - 2, offset);
			offset++;
			gen(newlabel(), "DEC", offset - 1, 0, offset);
			offset++;
			//traverse(root);
		}
		| direct_declarator '[' ']' {
			$$ = new node();
			//printf("1284 ");
			$$ -> length = 3;
			$$->name="direct_declarator";
			$$->children=new node* [3];
			$$->children[0] = $1;
			$$->children[1] = $2.ntnode;
			$$->children[2] = $3.ntnode;
		}
		| direct_pre_declarator parameter_type_list ')' {
			$$ = new node();
			//printf("1293 ");
			$$ -> length = 4;
			$$->name="direct_declarator";
			$$->children=new node* [4];
		}
		| direct_pre_declarator identifier_list ')' {
			$$ = new node();
			//printf("1303 ");
			$$ -> length = 4;
			$$->name="direct_declarator";
			map<string, typenode*>::iterator iter;
			for(iter = s.back()->vartable.begin();iter!=s.back()->vartable.end();iter++){
				s[s.size()-2]->vartable[iter->first] = iter->second;
			}	
			s.pop_back();  
		}
		| direct_pre_declarator ')' {
			$$ = new node();
			//printf("1313 ");
			$$ -> length = 3;
			$$->name="direct_declarator";
			$$->children=new node* [3];
			fun_name2 = var_name;
			// cout<<endl<<"----------------------"<<endl;
			// cout<<"1313->fun_name2:"<<fun_name2<<endl;
			gen(newlabel(), "fun", 0, 0, 0);
		}
		;

	pointer
		: '*' {
			$$ = new node();
			//printf("1325 ");
			$$ -> name = "pointer";
			$$ -> length = 1;
			$$ -> children = new node* [1];
			$$ -> children[0] = $1.ntnode;

			typenode* temp = new typenode("pointer");
			temp->left=rFlag();
			temp->width = 4;
			// cout<<"1325: temp->name:"<<temp->name<<endl;
			flag = !flag;
			wFlag(*temp);
			// cout<<"1325-->"<<endl;						
			// traverse(temp);
		}
		| '*' type_qualifier_list { // *const
			$$ = new node ();
			$$ -> name = "pointer";
			$$ -> length = 2;
			$$ -> children = new node* [2];
			$$ -> children[0] = $1.ntnode;
			$$ -> children[1] = $2;
		}
		| '*' pointer { // **
			$$ = new node ();
			$$ -> name = "pointer";
			$$ -> length = 2;
			$$ -> children = new node* [2];
			$$ -> children[0] = $1.ntnode;
			$$ -> children[1] = $2;

			typenode* temp = new typenode("pointer");
			temp->left = rFlag();
			temp->width = 4;
			flag = !flag;
			wFlag(*temp);
		}
		| '*' type_qualifier_list pointer { //*const*
			$$ = new node ();
			$$ -> name = "pointer";
			$$ -> length = 2;
			$$ -> children = new node* [2];
			$$ -> children[0] = $1.ntnode;
			$$ -> children[1] = $2;
		}
		;

	type_qualifier_list
		: type_qualifier {
			$$ = new node();
			//printf("1359 ");
			$$ -> name = "type_qualifier_list";
			$$ -> length = 1;
			$$ -> children = new node* [1];
			$$ -> children[0] = $1;
		}
		| type_qualifier_list type_qualifier {
			$$ = new node();
			//printf("1366 ");
			$$ -> name = "type_qualifier_list";
			$$ -> children = new node* [2];
			$$ -> length = 2;
			$$ -> children[0] = $1;
			$$ -> children[1] = $2;
		}
		;


	parameter_type_list
		: parameter_list {
			$$ = new node();
			//printf("1378 ");
			$$ -> name = "parameter_type_list";
			$$ -> length = 1;
			$$ -> children = new node* [1];
			$$ -> children[0] = $1;

			type3->left = rFlag();
			// cout<<"[1378:type3->left]"<<type3->left->name<<endl;
			// traverse(type3->left);

			gen(newlabel(), "fun", 0, 0, 0);
		}
		| parameter_list ',' ELLIPSIS {
			$$ = new node();
			//printf("1385 ");
			$$ -> name = "parameter_type_list";
			$$ -> length = 3;
			$$ -> children = new node* [3];
			$$ -> children[0] = $1;
			$$ -> children[1] = $2.ntnode;
			$$ -> children[2] = $3.ntnode;
		}
		;

	parameter_list
		: parameter_declaration {
			$$ = new node();
			//printf("1397 ");
			$$ -> name = "parameter_list";
			$$ -> length = 1;
			$$ -> children = new node* [1];
			$$ -> children[0] = $1;
		}
		| parameter_list ',' parameter_declaration {
			$$ = new node();
			//printf("1404 ");
			$$ -> name = "parameter_list";
			$$ -> length = 3;
			$$ -> children = new node* [3];
			$$ -> children[0] = $1;
			$$ -> children[1] = $2.ntnode;
			$$ -> children[2] = $3;
			typenode *temp = new typenode("X");
			flag = !flag;
			temp->left = rFlag();
			// cout<<"1404"<<endl<<"rFlag()"<<temp->left->name<<endl;
			flag = !flag;
			temp->right = rFlag();
			wFlag(*temp);
		}
		;		

	parameter_declaration
		: declaration_specifiers declarator {
			$$ = new node();
			//printf("1416 ");
			$$ -> name = "parameter_declaration";
			$$ -> length = 2;
			$$ -> children = new node* [2];
			$$ -> children[0] = $1;
			$$ -> children[1] = $2;
			gen(newlabel(), "param", 0, 0, $2 -> type.addr);
		}
		| declaration_specifiers abstract_declarator {
			$$ = new node();
			//printf("1424 ");
			$$ -> name = "parameter_declaration";
			$$ -> children = new node* [2];
			$$ -> children[0] = $1;
			$$ -> children[1] = $2;
		}
		| declaration_specifiers {
			$$ = new node();
			//printf("1431 ");
			$$ -> name = "parameter_declaration";
			$$ -> length = 1;
			$$ -> children = new node* [1];
			$$ -> children[0] = $1;
		}
		;

	identifier_list
		: ID {	
			$$ = new node();
			//printf("1441 ");
			$$ -> name = "identifier_list";
			$$ -> length = 1;
			$$ -> children = new node* [1];
			$$ -> children[0] = $1.ntnode;
			int tmp = $1.ntnode->type.addr;
			rFlag()->addr = tmp;
			s.back()->vartable[$1.ntnode->name] = rFlag();
            var_set.insert($1.ntnode->type.addr);
			// offset += rFlag()->width;
			offset += 1;
			$1.ntnode->type = *rFlag();
			//gen(newlabel(), "DEC", $1.ntnode->type.width, 0, $1.ntnode->type.addr);
		}
		| identifier_list ',' ID {
			$$ = new node();
			//printf("1448 ");   
			$$ -> name = "identifier_list";
			$$ -> length = 3;
			$$ -> children = new node* [3];
			$$ -> children[0] = $1;
			$$ -> children[1] = $2.ntnode;
			$$ -> children[2] = $3.ntnode;
			int tmp = $3.ntnode->type.addr;
			rFlag()->addr = tmp;
			s.back()->vartable[$3.ntnode->name] = rFlag();	
			var_set.insert($3.ntnode->type.addr);
			// offset += rFlag()->width;
			offset += 1;
			$3.ntnode->type = *rFlag();
			//gen(newlabel(), "DEC", $3.ntnode->type.width, 0, $3.ntnode->type.addr);
		}
		;

	type_name
		: specifier_qualifier_list  {
			$$ = new node();
			//printf("1460 ");
			$$ -> name = "type_name";
			$$ -> length = 1;
			$$ -> children = new node* [1];
			$$ -> children[0] = $1;
		}  
		| specifier_qualifier_list abstract_declarator  {
			$$ = new node();
			//printf("1467 ");  
			$$ -> name = "type_name";
			$$ -> length = 2;
			$$ -> children = new node* [2];
			$$ -> children[0] = $1;
			$$ -> children[1] = $2;
		}
		;

	abstract_declarator
		: pointer {
			$$ = new node();
			//printf("1478 ");
			$$ -> name = "abstract_declarator";
			$$ -> length = 1;
			$$ -> children = new node* [1];
			$$ -> children[0] = $1;
		}
		| direct_abstract_declarator {
			$$ = new node();
			//printf("1485 ");
			$$ -> name = "abstract_declarator";
			$$ -> length = 1;
			$$ -> children = new node* [1];
			$$ -> children[0] = $1;
		}
		| pointer direct_abstract_declarator {
			$$ = new node();
			//printf("1492 ");
			$$ -> name = "abstract_declarator";
			$$ -> length = 2;
			$$ -> children = new node* [2];
			$$ -> children[0] = $1;
			$$ -> children[1] = $2;
		}
		;

	direct_abstract_declarator
		: '(' abstract_declarator ')' {
			$$ = new node();
			//printf("1503 ");
			$$ -> name = "direct_abstract_declarator";
			$$ -> length = 3;
			$$ -> children = new node* [3];
			$$ -> children[0] = $1.ntnode;
			$$ -> children[1] = $2;
			$$ -> children[2] = $3.ntnode;
			s.pop_back();  
		}
		| '[' ']' {
			$$ = new node();
			//printf("1512 ");
			$$ -> name = "direct_abstract_declarator";
			$$ -> length = 2;		
			$$ -> children = new node* [2];
			$$ -> children[0] = $1.ntnode;
			$$ -> children[1] = $2.ntnode;
		}
		| '[' constant_exp ']' {
			$$ = new node();
			//printf("1520 ");
			$$ -> name = "direct_abstract_declarator";
			$$ -> length = 3;
			$$ -> children = new node* [3];
			$$ -> children[0] = $1.ntnode;
			$$ -> children[1] = $2;
			$$ -> children[2] = $3.ntnode;
		}
		| direct_abstract_declarator '[' ']' {
			$$ = new node();
			//printf("1529 ");
			$$ -> name = "direct_abstract_declarator";
			$$ -> length = 3;
			$$ -> children = new node* [3];
			$$ -> children[0] = $1;
			$$ -> children[1] = $2.ntnode;
			$$ -> children[2] = $3.ntnode;
		}
		| direct_abstract_declarator '[' constant_exp ']' {
			$$ = new node();
			//printf("1538 ");
			$$ -> name = "direct_abstract_declarator";
			$$ -> length = 4;
			$$ -> children = new node* [4];
			$$ -> children[0] = $1;
			$$ -> children[1] = $2.ntnode;
			$$ -> children[2] = $3;
			$$ -> children[3] = $4.ntnode;
		}
		| '(' ')' {
			$$ = new node();
			//printf("1548 ");
			$$ -> name = "direct_abstract_declarator";
			$$ -> length = 2;
			$$ -> children = new node* [2];
			$$ -> children[0] = $1.ntnode;
			$$ -> children[1] = $2.ntnode;
			s.pop_back();  
		}
		| '(' parameter_type_list ')' {
			$$ = new node();
			//printf("1556 ");
			$$ -> name = "direct_abstract_declarator";
			$$ -> length = 3;
			$$ -> children = new node* [3];
			$$ -> children[0] = $1.ntnode;
			$$ -> children[1] = $2;
			$$ -> children[2] = $3.ntnode;
			s.pop_back();  
		}
		| direct_abstract_declarator '(' ')' {
			$$ = new node();
			//printf("1565 ");
			$$ -> name = "direct_abstract_declarator";
			$$ -> length = 3;
			$$ -> children = new node* [3];
			$$ -> children[0] = $1;
			$$ -> children[1] = $2.ntnode;
			$$ -> children[2] = $3.ntnode;
			s.pop_back();  
		}
		| direct_abstract_declarator '(' parameter_type_list ')' {
			$$ = new node();
			//printf("1574 ");
			$$ -> name = "direct_abstract_declarator";
			$$ -> length = 4;
			$$ -> children = new node* [4];
			$$ -> children[0] = $1;
			$$ -> children[1] = $2.ntnode;
			$$ -> children[2] = $3;
			$$ -> children[3] = $4.ntnode;
			s.pop_back();  
		}
		;

	initializer
		: assignment_exp  {
			$$ = new node();
			//printf("1587 ");
			$$->name = $1->name;
			$$ -> length = 1;
			$$ -> children = new node* [1];
			$$ -> children[0] = $1;

			$$->type = $1->type;
		}
		| '{' initializer_list '}'  {
			$$ = new node();
			//printf("1594 ");
			$$ -> name = "initializer";
			$$ -> length = 3;
			$$ -> children = new node* [3];
			$$ -> children[0] = $1.ntnode;
			$$ -> children[1] = $2;
			$$ -> children[2] = $3.ntnode;
		}
		| '{' initializer_list ',' '}'  {
			$$ = new node();
			//printf("1603 ");
			$$ -> name = "initializer";
			$$ -> length = 4;
			$$ -> children = new node* [4];
			$$ -> children[0] = $1.ntnode;
			$$ -> children[1] = $2;
			$$ -> children[2] = $3.ntnode;
			$$ -> children[3] = $4.ntnode;
		}
		;

	initializer_list
		: initializer  {
			$$ = new node();
			//printf("1616 ");
			$$ -> name = "initializer_list";
			$$ -> length = 1;
			$$ -> children = new node* [1];
			$$ -> children[0] = $1;
		}
		| initializer_list ',' initializer  {
			$$ = new node();
			//printf("1623 ");
			$$ -> name = "initializer_list";
			$$ -> length = 3;
			$$ -> children = new node* [3];
			$$ -> children[0] = $1;
			$$ -> children[1] = $2.ntnode;
			$$ -> children[2] = $3;
		}
		;
	other
		:compound_statement {
			$$ = new node();
			//printf("1635 ");
			$$ -> name = "other";
			$$ -> nextlist = $1->nextlist;
			// cout << $1->nextlist->size() << "???????????????" << endl;
			$$ -> truelist = $1 -> truelist;
			$$ -> falselist = $1 -> falselist;
			traverse_vartable(s.size()-1);
		}
		| exp_statement {
			$$ = new node();
			//printf("1636 ");
			$$->name = $1->name;
			$$ -> nextlist = $1->nextlist;
		}
		|iteration_statement {
			$$ = new node();
			//printf("1637 ");
			$$ -> name = "other";
			$$ -> nextlist = $1->nextlist;
		}
		|jump_statement{
			$$ = new node();
			//printf("1638 ");
			$$ -> name = "other";
			$$ -> nextlist = $1->nextlist;
		}
		;
	statement
		: labeled_statement {
			$$ = new node();
			//printf("1644 ");
			$$ -> name = "statement";
			$$ -> length = 1;
			$$ -> children = new node* [1];
			$$ -> children[0] = $1;

			traverse_vartable(s.size() - 1);
		}
		| other {
			$$ = new node();
			//printf("1669 ");
			$$ -> name = "xx";
			$$ -> nextlist = $1->nextlist;
			$$ -> truelist = $1 -> truelist;
			$$ -> falselist = $1 -> falselist;
		}
		| selection_statement {
			$$ = new node();
			//printf("1670 ");
			$$ -> name = "other";
			$$->nextlist = $1->nextlist;
		}
		;	
	default_pre
	: DEFAULT ':'{
		
	};
	labeled_statement
		: ID ':' statement  {
			$$ = new node();
			//printf("1680 ");
			$$ -> name = "labeled_statement";
			$$ -> length = 3;
			$$ -> children = new node* [3];
			$$ -> children[0] = $1.ntnode;
			$$ -> children[1] = $2.ntnode;
			$$ -> children[2] = $3;
		}
		| CASE constant_exp ':' M statement  {
			$$ = new node();
			//printf("1689 ");
			$$ -> name = "labeled_statement";
		}
		| default_pre statement  {
			$$ = new node();
			//printf("1699 ");
			$$ -> name = "labeled_statement";
		}
		;

	compound_statement
		: '{' '}' {
			$$ = new node();
			//printf("1711 ");
			$$ -> name = "compound_statement";
			$$ -> length = 2;
			$$ -> children = new node* [2];
			$$ -> children[0] = $1.ntnode;
			$$ -> children[1] = $2.ntnode;
		}
		| '{' statement_list '}' {
			$$ = new node();
			//printf("1719 ");
			$$ -> name = "compound_statement";
			$$->nextlist = $2->nextlist;
			$$ -> truelist = $2 -> truelist;
			$$ -> falselist = $2 -> falselist;
		}
		| '{' declaration_list '}' {
			$$ = new node();
			//printf("1728 ");
			$$ -> name = "compound_statement";	
			$$->nextlist = $2->nextlist;
		}
		| '{' declaration_list statement_list '}' {
			$$ = new node();
			//printf("1737 ");
			$$ -> name = "compound_statement";
			$$->nextlist= $3->nextlist ;
		}
		;

	declaration_list
		: declaration {
			$$ = new node();
			//printf("1750 ");
			$$ -> name = "declaration_list";
			$$ -> length = 1;
			$$ -> children = new node* [1];
			$$ -> children[0] = $1;

			traverse_vartable(s.size() - 1);
		}
		| declaration_list M declaration {
			$$ = new node();
			//printf("1757 ");
			$$ -> name = "declaration_list";
			backpatch($1->nextlist , $2->instr); 
			$$->nextlist =$3->nextlist; 
		}
		;

	statement_list
		: statement {
			$$ = new node();
			//printf("1768 ");
			$$ -> name = "statement_list";
			$$ -> length = 1;
			$$ -> children = new node* [1];
			$$ -> children[0] = $1;
			$$ -> nextlist = $1->nextlist;
		}
		| statement_list M statement {
			$$ = new node();
			// cout<<"$2->instr:"<<$2->instr<<endl;
			//printf("1775 ");
			$$ -> name = "statement_list";
			cout << "--------------============";
			backpatch($1->nextlist , $2->instr); 
			$$->nextlist = $3->nextlist; 
		}
		;

	exp_statement
		: ';' {
			$$ = new node();
			//printf("1786 ");
			$$ -> name = "exp_statement";
			$$ -> length = 1;
			$$ -> children = new node* [1];
			$$ -> children[0] = $1.ntnode;
		}
		| exp ';' {
			$$ = new node();
			//printf("1793 ");
			$$->name = $1->name;
			$$ -> length = 2;
			$$ -> children = new node* [2];
			$$ -> children[0] = $1;
			$$ -> children[1] = $2.ntnode;
			$$ -> nextlist = $1->nextlist;
			$$ -> falselist = $1 -> falselist;
			$$ -> truelist = $1 -> truelist; 
		}
		;
	stmt 
		: matched_statement {
			$$ = new node();
			//printf("1794 ");
			$$ -> name = "stmt";
			$$ -> length = 1;
			$$ -> children = new node* [1];
			$$ -> children[0] = $1;
			$$->type=$1->type;
			$$->nextlist = $1->nextlist;
		}
		| open_statement {
			$$ = new node(); 
			//printf("1795 ");
			$$ -> name = "stmt";
			$$ -> length = 1;
			$$ -> children = new node* [1];
			$$ -> children[0] = $1;
			$$->nextlist = $1->nextlist;
		}
		;
	matched_statement
		: IF '(' exp ')' M matched_statement P ELSE M matched_statement{
			$$ = new node();
			//printf("1803 ");
			$$ -> name = "matched_statement";
			backpatch($3->truelist, $5->instr);  
			backpatch($3->falselist, $9->instr);    
			$$->nextlist=merge($6->nextlist, $7->nextlist, $10->nextlist); 	
			s.pop_back();
			traverse_vartable(s.size() - 1);	 					
		}
		| other {
			$$ = new node();
			//printf("1815 ");
			$$ -> name = "matched_statement";
			$$ -> length = 1;
			$$ -> children = new node* [1];
			$$ -> children[0] = $1;
			traverse_vartable(s.size() - 1);
			$$->type=$1->type; 
		}
		;
	open_statement
		: IF '(' exp ')' M stmt P{
			$$ = new node();
			//printf("1816 ");
			$$ -> name = "open_statement";
			$$->type=$6->type;
			s.pop_back();
			//traverse_vartable(s.size() - 1);
			backpatch($3->truelist, $5->instr);
			$$->nextlist =merge($3->falselist, $7->nextlist); 
		}
		| IF '(' exp ')' M matched_statement P ELSE M open_statement {
			$$ = new node();
			//printf("1817 ");
			$$ -> name = "open_statement";
			s.pop_back();
			traverse_vartable(s.size() - 1);
			backpatch($3->truelist, $5->instr);  
			backpatch($3->falselist, $9->instr);    
			$$->nextlist=merge($6->nextlist, $7->nextlist, $10->nextlist); 	
		}
		;
	selection_statement
		: stmt {
			$$ = new node();
			//printf("1818 ");
			$$ -> name = "selection_statement";
			$$ -> length = 1;
			$$ -> children = new node* [1];
			$$ -> children[0] = $1;
			$$->nextlist = $1->nextlist;
		}
		| switch_pre statement {
			$$ = new node();
			//printf("1825 ");
			$$ -> name = "selection_statement";
			s.pop_back();  
		}
		;
	switch_pre
	: SWITCH '(' exp ')'{
		    // $$->type = $3->type;
			// offset += $$->type.width;
			// switch_addr = $$->type.addr;			
			// gen(newlabel(), "=", $$->type.addr, 0, $3->type.addr);
			// default_label=newlabel();
			// gen(nextinstr,"j",0,0,default_label);
	};

	iteration_statement
		: WHILE M '(' exp ')' M statement {
			$$ = new node();
			//printf("1839 ");
			$$ -> name = "iteration_statement";
			backpatch($4->truelist, $6->instr); 
			backpatch($7->nextlist, $2->instr); 
			$$->nextlist = $4->falselist;
			gen(newlabel(), "j", 0, 0, $2->instr) ; 
			cout << $2->instr << "@";
			// s.pop_back();
			traverse_vartable(s.size()-1);
			s.pop_back(); 
			s.pop_back();
			traverse_vartable(s.size()-1);
		}
		| DO M statement WHILE M '(' exp ')' ';' {
			$$ = new node();
			//printf("1850 ");
			$$ -> name = "iteration_statement";
			backpatch($7->truelist, $2->instr); 
			backpatch($3->nextlist, $5->instr); 
			$$->nextlist = $7->falselist;
			gen(newlabel(), "j", 0, 0, $5->instr) ; 
			cout<<"WHILE"<<endl;
			traverse_vartable(s.size()-1);
			s.pop_back(); 
			s.pop_back();
			traverse_vartable(s.size()-1);
		}
| FOR '(' exp_statement M exp_statement ')' M statement {
			$$ = new node();
			printf("1863 ");
			$$ -> name = "iteration_statement";
			map<string, typenode*>::iterator iter;
			for(iter = s.back()->vartable.begin();iter!=s.back()->vartable.end();iter++){
				s[s.size()-2]->vartable[iter->first] = iter->second;
			}
			backpatch($5->truelist, $8->instr);
			// backpatch($8->nextlist, $5->instr);
			gen(newlabel(), "j", 0, 0, $4->instr);
			$8->nextlist = makelist($5->instr);
			$$->nextlist=$5->falselist;
			s.pop_back();		  
		}
		| FOR '(' exp_statement M exp_statement M exp P ')' M statement {
			
			$$ = new node();
			printf("1875 ");
			$$ -> name = "iteration_statement";
			backpatch($5->truelist, $10->instr);
			// backpatch($10->nextlist, $6->instr);
			gen(newlabel(), "j", 0, 0, $6->instr);
			$10->nextlist = makelist($6->instr);
			backpatch($8->nextlist, $4->instr);
			$$->nextlist= $5->falselist;
			map<string, typenode*>::iterator iter;
			for(iter = s.back()->vartable.begin();iter!=s.back()->vartable.end();iter++)
			{
				s[s.size()-2]->vartable[iter->first] = iter->second;
			}
			cout<<"FOR"<<endl;
			traverse_vartable(s.size()-1);
			s.pop_back();
			s.pop_back();
			traverse_vartable(s.size()-1);
		}
		;


	jump_statement
		: GOTO ID ';'  {
			$$ = new node();
			//printf("1891 ");
			$$ -> name = "jump_statement";
			$$ -> length = 3;
			$$ -> children = new node* [3];
			$$ -> children[0] = $1.ntnode;
			$$ -> children[1] = $2.ntnode;
			$$ -> children[2] = $3.ntnode;
		}
		| CONTINUE ';'  {
			$$ = new node();
			//printf("1900 ");
			$$ -> name = "jump_statement";
			$$ -> length = 2;
			$$ -> children = new node* [2];
			$$ -> children[0] = $1.ntnode;
			$$ -> children[1] = $2.ntnode;
		}
		| BREAK ';'  {
			$$ = new node();
			//printf("1908 ");
			$$ -> name = "jump_statement";
			$$ -> length = 2;
			$$ -> children = new node* [2];
			$$ -> children[0] = $1.ntnode;
			$$ -> children[1] = $2.ntnode;
		}
		| RETURN ';'  {
			$$ = new node();
			//printf("1916 ");
			$$ -> name = "jump_statement";
			$$ -> length = 2;
			$$ -> children = new node* [2];
			$$ -> children[0] = $1.ntnode;
			$$ -> children[1] = $2.ntnode;
			rtn_stmt.push(&voidnode);		
		}
		| RETURN exp ';'  {
			$$ = new node();
			//printf("1924 ");
			$$ -> name = "jump_statement";
			$$ -> length = 3;
			$$ -> children = new node* [3];
			$$ -> children[0] = $1.ntnode;
			$$ -> children[1] = $2;
			$$ -> children[2] = $3.ntnode;	
			rtn_stmt.push(&($2->type));
			gen(newlabel(), "RETURN", 0, 0, $2->type.addr);
			
		}
		;

	translation_unit
		: external_declaration {
			$$ = new node();
			//printf("1946 ");
			$$ -> name = "translation_unit";
			$$ -> length = 1;
			$$ -> children = new node* [1];
			$$ -> children[0] = $1;
		}
		| translation_unit external_declaration {
			$$ = new node();
			//printf("1953 ");
			$$ -> name = "translation_unit";
			$$ -> length = 2;
			$$ -> children = new node* [2];
			$$ -> children[0] = $1;
			$$ -> children[1] = $2;
		}
		;

	external_declaration
		: function_definition {
			$$ = new node();
			//printf("1964 ");
			$$ -> name = "external_declaration";
			$$ -> length = 1;
			$$ -> children = new node* [1];
			$$ -> children[0] = $1;
		}
		| declaration {
			$$ = new node();
			//printf("1971 ");
			$$ -> name = "external_declaration";
			$$ -> length = 2;
			$$ -> children = new node* [2];
			$$ -> children[0] = $1;
		}
		;

	function_definition
		: declaration_specifiers declarator declaration_list compound_statement {
			$$ = new node();
			//printf("1981 ");
			$$ -> name = "function_definition";
			type3->right = &($1->type);
			//cout<<"$$$$$$$$$$$$$$$$$$$type3:"<<type3<<endl;
			s.back()->vartable[fun_name2] = type3;
			// var_set.insert(fun_name);
			//gen(newlabel(), "DEC", -1, 0, fun_addr);
			if (rtn_stmt.size() == 0 && type3->right->name !="void" ){
				cout<<endl<<"-----------------------"<<endl;
				cout<<"|must return a value!!|"<<endl;
				cout<<"-----------------------"<<endl;
			}
			while(rtn_stmt.size()>0){ 
			typenode *a = rtn_stmt.top();
			//cout<<"stack top"<<a->name<<endl;
			if(!check_type(a,&($1->type)))
			{
				cout<<a->name+"mismatches with "
				+$1->type.name<<endl;
			}
			rtn_stmt.pop();
			}	
			s.pop_back();
		}
		| declaration_specifiers declarator compound_statement {
			$$ = new node();
			//printf("1991 ");
			$$ -> name = "function_definition";
			$$ -> nextlist = $3 -> nextlist;

			
			type3->right = &($1->type);
			// cout<<"[1991:type3->right]:"<<$1->type.name<<endl;
			// cout<<"fun_name------------>"<<fun_name<<endl;
			
			// var_set.insert(fun_name);
			// cout<<endl<<"---------------type3"<<type3->name<<endl;
			// cout<<"----------------fun_name2"<<fun_name2<<endl;
			// cout<<"6666666666666"<<endl;
			s[s.size()-2]->vartable[fun_name2] = type3;
			//s.back()->vartable[fun_name] = type3;
			
			//cout<<"/./././././././"<<fun_addr<<endl;
			//gen(newlabel(), "DEC", -1, 0, fun_addr);

			if (rtn_stmt.size() == 0 && type3->right->name != "void"){
				cout<<endl<<"-----------------------"<<endl;
				cout<<"|must return a value!!|"<<endl;
				cout<<"-----------------------"<<endl;
			}
			while(rtn_stmt.size()>0){
				typenode *a = rtn_stmt.top();
				if(!check_type(a,&($1->type)))
				{
					if($1->type.name == "void"){
						cout<<endl<<"-------------------------------"<<endl;
						cout<<"|cannot return " + a->name + " to void!!|"<<endl;
						cout<<"-------------------------------"<<endl;
					}
					else{
						cout<<endl<<"-------------------------------"<<endl;						
						cout<<"|must return " + $1->type.name + ", not " + a->name + "!!|"<<endl;
						cout<<"-------------------------------"<<endl;						
					}
				}
				rtn_stmt.pop();
			}
			s.pop_back();	
			traverse_vartable(s.size()-1);	
		}
		| declarator declaration_list compound_statement {
			$$ = new node();
			//printf("2000 ");
			$$ -> name = "function_definition";
			$$ -> length = 3;
			$$ -> children = new node* [3];
			$$ -> children[0] = $1;
			$$ -> children[1] = $2;
			$$ -> children[2] = $3;
			type3->right = &($1->type);
			s.back()->vartable[fun_name2] = type3;
			// var_set.insert(fun_name);
			// cout<<"/./././././././"<<fun_addr<<endl;
			//gen(newlabel(), "DEC", -1, 0, fun_addr);
			if (rtn_stmt.size() == 0 && type3->right->name != "void"){
				cout<<endl<<"------------------------------------------"<<endl;
				cout<<"|must return a value " + type3->right->name+"!!|"<<endl;
				cout<<"------------------------------------------"<<endl;
			}		
			while(rtn_stmt.size()>0){
			typenode *a = rtn_stmt.top();
			if(!check_type(a,&($1->type)))
			{cout<<"------------------"<<endl;
				cout<<"|type error!!|"<<endl;
				cout<<"--------------"<<endl;
			}
			rtn_stmt.pop();
			}	
			s.pop_back();
		}
		| declarator compound_statement {
			$$ = new node();
			//printf("2009 ");
			$$ -> name = "function_definition";
			$$ -> length = 2;
			$$ -> children = new node* [2];
			$$ -> children[0] = $1;
			$$ -> children[1] = $2;
			type3->right = &($1->type);
			s.back()->vartable[fun_name2] = type3;
			// var_set.insert(fun_name);
			//gen(newlabel(), "DEC", -1, 0, fun_addr);
			if (rtn_stmt.size() == 0 && type3->right->name != "void"){
				cout<<endl<<"------------------------------------------"<<endl;
				cout<<"|must return a value " + type3->right->name+"!!|"<<endl;
				cout<<"------------------------------------------"<<endl;
			}	
			while(rtn_stmt.size()>0){
			typenode *a = rtn_stmt.top();
			if(!check_type(a,&($1->type)))
			{
				cout<<"--------------"<<endl;
				cout<<"|type error!!|"<<endl;
				cout<<"--------------"<<endl;
			}
			rtn_stmt.pop();
			}	
			s.pop_back();
		}
		;



	%%

	/////////////////////////////////////////////////////////////////////////////
	// programs section

	int main(void)
	{
		s.push_back(new varmap());
	//print-function
		typenode *type5 = new typenode("fun");
		type5->right = &voidnode;
		type5->left = &intnode;
		s[s.size()-1]->vartable["print"] = type5;
		s.push_back(new varmap());

	//print-function
		type5->right = &intnode;
		type5->left = &intnode;
		s[s.size()-1]->vartable["read"] = type5;
		s.push_back(new varmap());

		FILE *stream;
		freopen_s(&stream, "../input.c", "r", stdin);
	//	freopen_s(&stream, "out.txt", "w", stdout);
	//	cout << "Name\t\tElement\t\tValue\t\tLine" << endl;
		int n = 1;
		mylexer lexer;
		myparser parser;
		if (parser.yycreate(&lexer)) {
			if (lexer.yycreate(&parser)) {
				n = parser.yyparse();
				show_code();
				transcode();
			}
		}
		file.close();
		getchar();
		return 0;
	}