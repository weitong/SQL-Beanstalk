stmtblock
	: stmtmulti
	;


td_command
	: DataBaseCommand

	;


DataBaseCommand
	: DATABASE IDENT

	;

IDENT
	: SQL_SQL_IDENTIFIER

	| SQL_SH_IDENTIFIER
	;

SQL_SH_IDENTIFIER
	: SQL_DOLLAR SQL_LC SQL_SQL_IDENTIFIER SQL_RC

	| SQL_DOLLAR SQL_SQL_IDENTIFIER
	;

NotifyStmt
	: NOTIFY ColId notify_payload
	;

CollectStatisticsStmt
	: COLLECT STATISTICS ON relation_expr COLUMN columnref 	

	| COLLECT STATISTICS ON relation_expr COLUMN SQL_LP columnref_list SQL_RP 

	| COLLECT STATISTICS ON relation_expr INDEX index_name 

	| COLLECT STATISTICS ON relation_expr INDEX SQL_LP columnref_list SQL_RP 
						
	| COLLECT STATISTICS ON TEMPORARY relation_expr COLUMN columnref 
						
	| COLLECT STATISTICS ON TEMPORARY relation_expr COLUMN SQL_LP columnref_list SQL_RP 
						
	| COLLECT STATISTICS ON TEMPORARY relation_expr INDEX index_name 
						
	| COLLECT STATISTICS ON TEMPORARY relation_expr INDEX SQL_LP columnref_list SQL_RP 
						
	| COLLECT STATISTICS relation_expr COLUMN columnref 
								
	| COLLECT STATISTICS relation_expr COLUMN SQL_LP columnref_list SQL_RP 
								
	| COLLECT STATISTICS relation_expr INDEX index_name 
								
	| COLLECT STATISTICS relation_expr INDEX SQL_LP columnref_list SQL_RP 
								
	| COLLECT STATISTICS TEMPORARY relation_expr COLUMN columnref 
								
	| COLLECT STATISTICS TEMPORARY relation_expr COLUMN SQL_LP columnref_list SQL_RP 
								
	| COLLECT STATISTICS TEMPORARY relation_expr INDEX index_name 
								
	| COLLECT STATISTICS TEMPORARY relation_expr INDEX SQL_LP columnref_list SQL_RP 
	;							

columnref_list
	: columnref 		
	| columnref_list SQL_COMMA columnref 
	;			

opt_instead
	: INSTEAD 
						
	| ALSO 
						
	| /* empty */ 
						
	;

ViewStmt
	: CREATE OptTemp VIEW qualified_name opt_column_list opt_reloptions AS SelectStmt opt_check_option 
						
	| CREATE OR REPLACE OptTemp VIEW qualified_name opt_column_list opt_reloptions AS SelectStmt opt_check_option 
	;

key_match
	: MATCH FULL 
						
	| MATCH PARTIAL 
						
	| MATCH SIMPLE 
						
	| /* empty */ 
						
	;

DropRuleStmt
	: DROP RULE name ON any_name opt_drop_behavior 
						
	| DROP RULE IF_P EXISTS name ON any_name opt_drop_behavior 
						
	;

attrs
	: SQL_DOT attr_name 
						
	| attrs SQL_DOT attr_name 
						
	;

row
	: ROW SQL_LP expr_list SQL_RP 
						
	| ROW SQL_LP SQL_RP 
						
	| SQL_LP expr_list SQL_COMMA a_expr SQL_RP 
						
	;

overlay_placing
	: PLACING a_expr 
						
	;

subquery_Op
	: all_Op 
						
	| OPERATOR SQL_LP any_operator SQL_RP 
						
	| LIKE 
						
	| NOT LIKE 
						
	| ILIKE 
						
	| NOT ILIKE 
						
	;

SimpleTypename
	: GenericType 
						
	| Numeric 
						
	| Bit 
						
	| Character_BIG 
						
	| ConstDatetime 
						
	| ConstInterval opt_interval 
						
	| ConstInterval SQL_LP Iconst SQL_RP opt_interval 
						
	| ConstGraphic 
	;

ConstGraphic
	: TD_GRAPHIC 

	| TD_GRAPHIC SQL_LP Iconst SQL_RP 

	
	| TD_VARGRAPHIC SQL_LP Iconst SQL_RP 

	
	| TD_LONG TD_VARGRAPHIC 
	;


opt_asymmetric
	: ASYMMETRIC 
						
	| /* empty */ 				
	;

opt_foreign_server_version
	: foreign_server_version 
						
	| /* empty */ 					
	;

cast_context
	: AS IMPLICIT_P 
						
	| AS ASSIGNMENT 
						
	| /* empty */ 					
	;

alter_extension_opt_item
	: TO ColId_or_Sconst 
						
	;

opt_or_replace
	: OR REPLACE 
						
	| /* empty */ 					
	;

index_params
	: index_elem 
						
	| index_params SQL_COMMA index_elem 				
	;

TransactionStmt
	: ABORT_P opt_transaction 
						
	| BEGIN_P opt_transaction transaction_mode_list_or_empty 
						
	| START TRANSACTION transaction_mode_list_or_empty 
						
	| COMMIT opt_transaction 
						
	| END_P opt_transaction 
						
	| ROLLBACK opt_transaction 
						
	| SAVEPOINT ColId 
						
	| RELEASE SAVEPOINT ColId 
						
	| RELEASE ColId 
						
	| ROLLBACK opt_transaction TO SAVEPOINT ColId 
						
	| ROLLBACK opt_transaction TO ColId 
						
	| PREPARE TRANSACTION Sconst 
						
	| COMMIT PREPARED Sconst 
						
	| ROLLBACK PREPARED Sconst 					
	;

c_expr
	: columnref 
						
	| AexprConst 
						
	| PARAM opt_indirection 
						
	| SQL_LP a_expr SQL_RP opt_indirection 
						
	| case_expr 
						
	| func_expr 
						
	| select_with_parens %prec UMINUS 
						
	| EXISTS select_with_parens 
						
	| ARRAY select_with_parens 
						
	| ARRAY array_expr 
						
	| row 
						
	| paren_func_expr SQL_LP Typename SQL_RP 

	| case_expr SQL_LP Typename SQL_RP
	
	;

createdb_opt_list
	: createdb_opt_list createdb_opt_item 
						
	| /* empty */ 				
	;

def_list
	: def_elem 
						
	| def_list SQL_COMMA def_elem 					
	;

position_list
	: b_expr IN_P b_expr 
						
	| /* empty */ 				
	;

into_clause
	: INTO OptTempTableName 
						
	| /* empty */ 					
	;

opt_validator
	: validator_clause 
						
	| /* empty */ 				
	;

DeclareCursorStmt
	: DECLARE cursor_name cursor_options CURSOR opt_hold FOR SelectStmt 
						
	;

set_clause_list
	: set_clause 
						
	| set_clause_list SQL_COMMA set_clause 
						
	;

VariableSetStmt
	: SET set_rest 
						
	| SET LOCAL set_rest 
						
	| SET SESSION set_rest 
						
	;

AlterFdwStmt
	: ALTER FOREIGN DATA_P WRAPPER name opt_fdw_options alter_generic_options 
						
	| ALTER FOREIGN DATA_P WRAPPER name fdw_options 
						
	;

transaction_mode_item
	: ISOLATION LEVEL iso_level 
						
	| READ ONLY 
						
	| READ WRITE 
						
	| DEFERRABLE 
						
	| NOT DEFERRABLE 
						
	;

CreateSchemaStmt
	: CREATE SCHEMA OptSchemaName AUTHORIZATION RoleId OptSchemaEltList 
						
	| CREATE SCHEMA ColId OptSchemaEltList 
						
	;

AlterForeignServerStmt
	: ALTER SERVER name foreign_server_version alter_generic_options 
						
	| ALTER SERVER name foreign_server_version 
						
	| ALTER SERVER name alter_generic_options 
						
	;

privilege_list
	: privilege 
						
	| privilege_list SQL_COMMA privilege 
						
	;

copy_file_name
	: Sconst 
						
	| STDIN 
						
	| STDOUT 
						
	;

CreateOpClassStmt
	: CREATE OPERATOR CLASS any_name opt_default FOR TYPE_P Typename USING access_method opt_opfamily AS opclass_item_list 
						
	;

event_trigger_when_item
	: ColId IN_P SQL_LP event_trigger_value_list SQL_RP 
						
	;

xml_attribute_list
	: xml_attribute_el 
						
	| xml_attribute_list SQL_COMMA xml_attribute_el 
						
	;

AlterOptRoleList
	: AlterOptRoleList AlterOptRoleElem 
						
	| /* empty */ 
						
	;

alter_generic_option_list
	: alter_generic_option_elem 
						
	| alter_generic_option_list SQL_COMMA alter_generic_option_elem 
						
	;

cte_list
	: common_table_expr 
						
	| cte_list SQL_COMMA common_table_expr 
						
	;

case_default
	: ELSE a_expr 
						
	| /* empty */ 
						
	;

stmt
	: AlterEventTrigStmt 
						
	| AlterDatabaseStmt 
						
	| AlterDatabaseSetStmt 
						
	| AlterDefaultPrivilegesStmt 
						
	| AlterDomainStmt 
						
	| AlterEnumStmt 
						
	| AlterExtensionStmt 
						
	| AlterExtensionContentsStmt 
						
	| AlterFdwStmt 
						
	| AlterForeignServerStmt 
						
	| AlterForeignTableStmt 
						
	| AlterFunctionStmt 
						
	| AlterGroupStmt 
						
	| AlterObjectSchemaStmt 
						
	| AlterOwnerStmt 
						
	| AlterSeqStmt 
						
	| AlterTableStmt 
						
	| AlterCompositeTypeStmt 
						
	| AlterRoleSetStmt 
						
	| AlterRoleStmt 
						
	| AlterTSConfigurationStmt 
						
	| AlterTSDictionaryStmt 
						
	| AlterUserMappingStmt 
						
	| AlterUserSetStmt 
						
	| AlterUserStmt 
						
	| AnalyzeStmt 
						
	| CheckPointStmt 
						
	| ClosePortalStmt 
						
	| ClusterStmt 
						
	| CommentStmt 
						
	| ConstraintsSetStmt 
						
	| CopyStmt 
						
	| CreateAsStmt 
						
	| CreateAssertStmt 
						
	| CreateCastStmt 
						
	| CreateConversionStmt 
						
	| CreateDomainStmt 
						
	| CreateExtensionStmt 
						
	| CreateFdwStmt 
						
	| CreateForeignServerStmt 
						
	| CreateForeignTableStmt 
						
	| CreateFunctionStmt 
						
	| CreateGroupStmt 
						
	| CreateOpClassStmt 
						
	| CreateOpFamilyStmt 
						
	| AlterOpFamilyStmt 
						
	| CreatePLangStmt 
						
	| CreateSchemaStmt 
						
	| CreateSeqStmt 
						
	| CreateStmt 
						
	| CreateTableSpaceStmt 
						
	| CreateTrigStmt 
						
	| CreateEventTrigStmt 
						
	| CreateRoleStmt 
						
	| CreateUserStmt 
						
	| CreateUserMappingStmt 
						
	| CreatedbStmt 
						
	| DeallocateStmt 
						
	| DeclareCursorStmt 
						
	| DefineStmt 
						
	| DeleteStmt 
						
	| DiscardStmt 
						
	| DoStmt 
						
	| DropAssertStmt 
						
	| DropCastStmt 
						
	| DropFdwStmt 
						
	| DropForeignServerStmt 
						
	| DropGroupStmt 
						
	| DropOpClassStmt 
						
	| DropOpFamilyStmt 
						
	| DropOwnedStmt 
						
	| DropPLangStmt 
						
	| DropRuleStmt 
						
	| DropStmt 
						
	| DropTableSpaceStmt 
						
	| DropTrigStmt 
						
	| DropRoleStmt 
						
	| DropUserStmt 
						
	| DropUserMappingStmt 
						
	| DropdbStmt 
						
	| ExecuteStmt 
						
	| ExplainStmt 
						
	| FetchStmt 
						
	| GrantStmt 
						
	| GrantRoleStmt 
						
	| IndexStmt 
						
	| InsertStmt 
						
	| ListenStmt 
						
	| LoadStmt 
						
	| LockStmt 
						
	| NotifyStmt 
						
	| PrepareStmt 
						
	| ReassignOwnedStmt 
						
	| ReindexStmt 
						
	| RemoveAggrStmt 
						
	| RemoveFuncStmt 
						
	| RemoveOperStmt 
						
	| RenameStmt 
						
	| RevokeStmt 
						
	| RevokeRoleStmt 
						
	| RuleStmt 
						
	| SecLabelStmt 
						
	| SelectStmt 
						
	| TransactionStmt 
						
	| TruncateStmt 
						
	| UnlistenStmt 
						
	| UpdateStmt 
						
	| VacuumStmt 
						
	| VariableResetStmt 
						
	| VariableSetStmt 
						
	| VariableShowStmt 
						
	| ViewStmt 
						
	| CollectStatisticsStmt 
								
	| TD_BT 
						
	| TD_ET 

	| td_command
						
	| /* empty */ 
						
	;

cursor_options
	: /* empty */ 
						
	| cursor_options NO SCROLL 
						
	| cursor_options SCROLL 
						
	| cursor_options BINARY 
						
	| cursor_options INSENSITIVE 
						
	;

using_clause
	: USING from_list 
						
	| /* empty */ 
						
	;

opt_distinct
	: DISTINCT 
						
	| DISTINCT ON SQL_LP expr_list SQL_RP 
						
	| ALL 
						
	| /* empty */ 
						
	;

cursor_name
	: name 
						
	;

when_clause_list
	: when_clause 
						
	| when_clause_list when_clause 
						
	;

event_trigger_value_list
	: SCONST 
						
	| event_trigger_value_list SQL_COMMA SCONST 
						
	;

indirection_el
	: SQL_DOT attr_name 
						
	| SQL_DOT SQL_MUL 
						
	| SQL_LB a_expr SQL_RB 
						
	| SQL_LB a_expr SQL_COLON a_expr SQL_RB 
						
	;

BitWithoutLength
	: BIT opt_varying 
						
	;

SetResetClause
	: SET set_rest 
						
	| VariableResetStmt 
						
	;

columnOptions
	: ColId WITH OPTIONS ColQualList 
						
	;

indirection
	: indirection_el 
						
	| indirection indirection_el 
						
	;

opt_grant_grant_option
	: WITH GRANT OPTION 
						
	| /* empty */ 
						
	;

AlterDatabaseStmt
	: ALTER DATABASE database_name opt_with alterdb_opt_list 
						
	| ALTER DATABASE database_name SET TABLESPACE name 
						
	;

copy_opt_list
	: copy_opt_list copy_opt_item 
						
	| /* empty */ 
						
	;

RemoveAggrStmt
	: DROP AGGREGATE func_name aggr_args opt_drop_behavior 
						
	| DROP AGGREGATE IF_P EXISTS func_name aggr_args opt_drop_behavior 
						
	;

alterdb_opt_item
	: CONNECTION LIMIT opt_equal SignedIconst 
						
	;

DropdbStmt
	: DROP DATABASE database_name 
						
	| DROP DATABASE IF_P EXISTS database_name 
						
	;

OptInherit
	: INHERITS SQL_LP qualified_name_list SQL_RP 
						
	| /* empty */ 
						
	;

transaction_mode_list_or_empty
	: transaction_mode_list 
						
	| /* empty */ 
						
	;

cluster_index_specification
	: USING index_name 
						
	| /* empty */ 
						
	;

ForeignTableElementList
	: ForeignTableElement 
						
	| ForeignTableElementList SQL_COMMA ForeignTableElement 
						
	;

opt_hold
	: /* empty */ 
						
	| WITH HOLD 
						
	| WITHOUT HOLD 
						
	;

DropOwnedStmt
	: DROP OWNED BY name_list opt_drop_behavior 
						
	;

sub_type
	: ANY 
						
	| SOME 
						
	| ALL 
						
	;

create_as_target
	: qualified_name opt_column_list OptWith OnCommitOption OptTableSpace 
						
	;

table_func_column
	: param_name func_type 
						
	;

DefACLOptionList
	: DefACLOptionList DefACLOption 
						
	| /* empty */ 
						
	;

xmlexists_argument
	: PASSING c_expr 
						
	| PASSING c_expr BY REF 
						
	| PASSING BY REF c_expr 
						
	| PASSING BY REF c_expr BY REF 
						
	;

qualified_name
	: ColId 
						
	| ColId indirection 
						
	;

enable_trigger
	: ENABLE_P 
						
	| ENABLE_P REPLICA 
						
	| ENABLE_P ALWAYS 
						
	| DISABLE_P 
						
	;

when_clause
	: WHEN a_expr THEN a_expr 
						
	;

notify_payload
	: SQL_COMMA Sconst 
						
	| /* empty */ 
						
	;

AlterDomainStmt
	: ALTER DOMAIN_P any_name alter_column_default 
						
	| ALTER DOMAIN_P any_name DROP NOT NULL_P 
						
	| ALTER DOMAIN_P any_name SET NOT NULL_P 
						
	| ALTER DOMAIN_P any_name ADD_P TableConstraint 
						
	| ALTER DOMAIN_P any_name DROP CONSTRAINT name opt_drop_behavior 
						
	| ALTER DOMAIN_P any_name DROP CONSTRAINT IF_P EXISTS name opt_drop_behavior 
						
	| ALTER DOMAIN_P any_name VALIDATE CONSTRAINT name 
						
	;

TableElement
	: columnDef 
						
	| TableLikeClause 
						
	| TableConstraint 
						
	;

CreateDomainStmt
	: CREATE DOMAIN_P any_name opt_as Typename ColQualList 
						
	;

opt_binary
	: BINARY 
						
	| /* empty */ 
						
	;

join_type
	: FULL join_outer 
						
	| LEFT join_outer 
						
	| RIGHT join_outer 
						
	| INNER_P 
						
	;

opt_oids
	: WITH OIDS 
						
	| /* empty */ 
						
	;

TableFuncElement
	: ColId Typename opt_collate_clause 
						
	;

CreateRoleStmt
	: CREATE ROLE RoleId opt_with OptRoleList 
						
	;

CopyStmt
	: COPY opt_binary qualified_name opt_column_list opt_oids copy_from copy_file_name copy_delimiter opt_with copy_options 
						
	| COPY select_with_parens TO copy_file_name opt_with copy_options 
						
	;

func_as
	: Sconst 
						
	| Sconst SQL_COMMA Sconst 
						
	;

select_with_parens
	: SQL_LP select_no_parens SQL_RP 
						
	| SQL_LP select_with_parens SQL_RP 
						
	;

select_clause
	: simple_select 
						
	| select_with_parens 
						
	;

having_clause
	: HAVING a_expr 
						
	| QUALIFY a_expr

	| /* empty */ 
								
	;

sample_clause
	: SAMPLE when_clause_list sample_default END_P 
								
	| SAMPLE a_expr 
						
	| 
	
	;

sample_default
	: ELSE a_expr 
								
	| 
						
	;

ColQualList
	: ColQualList ColConstraint 
						
	| /* empty */ 
						
	;

AlterEventTrigStmt
	: ALTER EVENT TRIGGER name enable_trigger 
						
	;

DefACLOption
	: IN_P SCHEMA name_list 
						
	| FOR ROLE name_list 
						
	| FOR USER name_list 
						
	;

fdw_option
	: HANDLER handler_name 
						
	| NO HANDLER 
						
	| VALIDATOR handler_name 
						
	| NO VALIDATOR 
						
	;

OptSeqOptList
	: SeqOptList 
						
	| /* empty */ 
						
	;

opt_name_list
	: SQL_LP name_list SQL_RP 
						
	| /* empty */ 
						
	;

ConstTypename
	: Numeric 
						
	| ConstBit 
						
	| ConstCharacter 
						
	| ConstDatetime 
						
	| ConstGraphic 
		// todo4
	
	;

alter_column_default
	: SET DEFAULT a_expr 
						
	| DROP DEFAULT 
						
	;

ExclusionConstraintElem
	: index_elem WITH any_operator 
						
	| index_elem WITH OPERATOR SQL_LP any_operator SQL_RP 
						
	;

var_list
	: var_value 
						
	| var_list SQL_COMMA var_value 
						
	;

CreateTableSpaceStmt
	: CREATE TABLESPACE name OptTableSpaceOwner LOCATION Sconst 
						
	;

opt_with_clause
	: with_clause 
						
	| /* empty */ 
						
	;

RenameStmt
	: ALTER AGGREGATE func_name aggr_args RENAME TO name 
						
	| ALTER COLLATION any_name RENAME TO name 
						
	| ALTER CONVERSION_P any_name RENAME TO name 
						
	| ALTER DATABASE database_name RENAME TO database_name 
						
	| ALTER DOMAIN_P any_name RENAME TO name 
						
	| ALTER DOMAIN_P any_name RENAME CONSTRAINT name TO name 
						
	| ALTER FOREIGN DATA_P WRAPPER name RENAME TO name 
						
	| ALTER FUNCTION function_with_argtypes RENAME TO name 
						
	| ALTER GROUP_P RoleId RENAME TO RoleId 
						
	| ALTER opt_procedural LANGUAGE name RENAME TO name 
						
	| ALTER OPERATOR CLASS any_name USING access_method RENAME TO name 
						
	| ALTER OPERATOR FAMILY any_name USING access_method RENAME TO name 
						
	| ALTER SCHEMA name RENAME TO name 
						
	| ALTER SERVER name RENAME TO name 
						
	| ALTER TABLE relation_expr RENAME TO name 
						
	| ALTER TABLE IF_P EXISTS relation_expr RENAME TO name 
						
	| ALTER SEQUENCE qualified_name RENAME TO name 
						
	| ALTER SEQUENCE IF_P EXISTS qualified_name RENAME TO name 
						
	| ALTER VIEW qualified_name RENAME TO name 
						
	| ALTER VIEW IF_P EXISTS qualified_name RENAME TO name 
						
	| ALTER INDEX qualified_name RENAME TO name 
						
	| ALTER INDEX IF_P EXISTS qualified_name RENAME TO name 
						
	| ALTER FOREIGN TABLE relation_expr RENAME TO name 
						
	| ALTER FOREIGN TABLE IF_P EXISTS relation_expr RENAME TO name 
						
	| ALTER TABLE relation_expr RENAME opt_column name TO name 
						
	| ALTER TABLE IF_P EXISTS relation_expr RENAME opt_column name TO name 
						
	| ALTER TABLE relation_expr RENAME CONSTRAINT name TO name 
						
	| ALTER FOREIGN TABLE relation_expr RENAME opt_column name TO name 
						
	| ALTER FOREIGN TABLE IF_P EXISTS relation_expr RENAME opt_column name TO name 
						
	| ALTER TRIGGER name ON qualified_name RENAME TO name 
						
	| ALTER EVENT TRIGGER name RENAME TO name 
						
	| ALTER ROLE RoleId RENAME TO RoleId 
						
	| ALTER USER RoleId RENAME TO RoleId 
						
	| ALTER TABLESPACE name RENAME TO name 
						
	| ALTER TABLESPACE name SET reloptions 
						
	| ALTER TABLESPACE name RESET reloptions 
						
	| ALTER TEXT_P SEARCH PARSER any_name RENAME TO name 
						
	| ALTER TEXT_P SEARCH DICTIONARY any_name RENAME TO name 
						
	| ALTER TEXT_P SEARCH TEMPLATE any_name RENAME TO name 
						
	| ALTER TEXT_P SEARCH CONFIGURATION any_name RENAME TO name 
						
	| ALTER TYPE_P any_name RENAME TO name 
						
	| ALTER TYPE_P any_name RENAME ATTRIBUTE name TO name opt_drop_behavior 
						
	;

func_args_list
	: func_arg 
						
	| func_args_list SQL_COMMA func_arg 
						
	;

OnCommitOption
	: ON COMMIT DROP 
						
	| ON COMMIT DELETE_P ROWS 
						
	| ON COMMIT PRESERVE ROWS 
						
	| /* empty */ 
						
	;

interval_second
	: SECOND_P 
						
	| SECOND_P SQL_LP Iconst SQL_RP 
						
	;

func_name
	: type_function_name 
						
	| ColId indirection 
						
	;

arg_class
	: IN_P 
						
	| OUT_P 
						
	| INOUT 
						
	| IN_P OUT_P 
						
	| VARIADIC 
						
	;

ColId_or_Sconst
	: ColId 
						
	| Sconst 
						
	;

from_clause
	: FROM from_list 
						
	| /* empty */ 
						
	;

type_function_name
	: IDENT 
						
	| unreserved_keyword 
						
	| type_func_name_keyword 
						
	;

lock_type
	: ACCESS SHARE 
						
	| ROW SHARE 
						
	| ROW EXCLUSIVE 
						
	| SHARE UPDATE EXCLUSIVE 
						
	| SHARE 
						
	| SHARE ROW EXCLUSIVE 
						
	| EXCLUSIVE 
						
	| ACCESS EXCLUSIVE 
						
	| ACCESS 
						
	;

select_limit
	: limit_clause offset_clause 
						
	| offset_clause limit_clause 
						
	| limit_clause 
						
	| offset_clause 
						
	;

opt_provider
	: FOR ColId_or_Sconst 
						
	| /* empty */ 
						
	;

constraints_set_list
	: ALL 
						
	| qualified_name_list 
						
	;

opt_for_locking_clause
	: for_locking_clause 
						
	| /* empty */ 
						
	;

DropTableSpaceStmt
	: DROP TABLESPACE name 
						
	| DROP TABLESPACE IF_P EXISTS name 
						
	;

reloptions
	: SQL_LP reloption_list SQL_RP 
						
	;

SeqOptElem
	: CACHE NumericOnly 
						
	| CYCLE 
						
	| NO CYCLE 
						
	| INCREMENT opt_by NumericOnly 
						
	| MAXVALUE NumericOnly 
						
	| MINVALUE NumericOnly 
						
	| NO MAXVALUE 
						
	| NO MINVALUE 
						
	| OWNED BY any_name 
						
	| START opt_with NumericOnly 
						
	| RESTART 
						
	| RESTART opt_with NumericOnly 
						
	;

AlterSeqStmt
	: ALTER SEQUENCE qualified_name SeqOptList 
						
	| ALTER SEQUENCE IF_P EXISTS qualified_name SeqOptList 
						
	;

opt_granted_by
	: GRANTED BY RoleId 
						
	| /* empty */ 
						
	;

array_expr
	: SQL_LB expr_list SQL_RB 
						
	| SQL_LB array_expr_list SQL_RB 
						
	| SQL_LB SQL_RB 
						
	;

opt_from_in
	: from_in 
						
	| /* empty */ 
						
	;

Iconst
	: ICONST 
						
	;

common_func_opt_item
	: CALLED ON NULL_P INPUT_P 
						
	| RETURNS NULL_P ON NULL_P INPUT_P 
						
	| STRICT_P 
						
	| IMMUTABLE 
						
	| STABLE 
						
	| VOLATILE 
						
	| EXTERNAL SECURITY DEFINER 
						
	| EXTERNAL SECURITY INVOKER 
						
	| SECURITY DEFINER 
						
	| SECURITY INVOKER 
						
	| LEAKPROOF 
						
	| NOT LEAKPROOF 
						
	| COST NumericOnly 
						
	| ROWS NumericOnly 
						
	| FunctionSetResetClause 
						
	;

func_arg_with_default
	: func_arg 
						
	| func_arg DEFAULT a_expr 
						
	| func_arg SQL_EQ a_expr 
						
	;

TriggerActionTime
	: BEFORE 
						
	| AFTER 
						
	| INSTEAD OF 
						
	;

privileges
	: privilege_list 
						
	| ALL 
						
	| ALL PRIVILEGES 
						
	| ALL SQL_LP columnList SQL_RP 
						
	| ALL PRIVILEGES SQL_LP columnList SQL_RP 
						
	;

AlterRoleSetStmt
	: ALTER ROLE RoleId opt_in_database SetResetClause 
						
	;

opt_table
	: TABLE 
						
	| /* empty */ 
						
	;

where_clause
	: WHERE a_expr 
						
	| /* empty */ 
						
	;

TableLikeClause
	: LIKE qualified_name TableLikeOptionList 
						
	;

OptForeignTableElementList
	: SQL_LP ForeignTableElementList SQL_RP 
						
	| SQL_LP SQL_RP 
						
	;

OptTableSpaceOwner
	: OWNER name 
						
	| /* empty */ 
						
	;

func_alias_clause
	: alias_clause 
						
	| AS SQL_LP TableFuncElementList SQL_RP 
						
	| AS ColId SQL_LP TableFuncElementList SQL_RP 
						
	| ColId SQL_LP TableFuncElementList SQL_RP 
						
	| /* empty */ 
						
	;

opt_index_definition
	: opt_unique PRIMARY INDEX opt_index_name SQL_LP target_list SQL_RP 

	| /* empty */ 
						
	;
opt_with_data
	: WITH DATA_P opt_index_definition OnCommitOption 
						
	| WITH NO DATA_P opt_index_definition OnCommitOption 
						
	| /* empty */ 
						
	;

sort_clause
	: ORDER BY sortby_list 
						
	;

createfunc_opt_list
	: createfunc_opt_item 
						
	| createfunc_opt_list createfunc_opt_item 
						
	;

opt_definition
	: WITH definition 
						
	| /* empty */ 
						
	;

key_update
	: ON UPDATE key_action 
						
	;

CreateTrigStmt
	: CREATE TRIGGER name TriggerActionTime TriggerEvents ON qualified_name TriggerForSpec TriggerWhen EXECUTE PROCEDURE func_name SQL_LP TriggerFuncArgs SQL_RP 
						
	| CREATE CONSTRAINT TRIGGER name AFTER TriggerEvents ON qualified_name OptConstrFromTable ConstraintAttributeSpec FOR EACH ROW TriggerWhen EXECUTE PROCEDURE func_name SQL_LP TriggerFuncArgs SQL_RP 
						
	;

substr_list
	: a_expr substr_from substr_for 
						
	| a_expr substr_for substr_from 
						
	| a_expr substr_from 
						
	| a_expr substr_for 
						
	| expr_list 
						
	| /* empty */ 
						
	;

CreateFdwStmt
	: CREATE FOREIGN DATA_P WRAPPER name opt_fdw_options create_generic_options 
						
	;

where_or_current_clause
	: WHERE a_expr 
						
	| WHERE CURRENT_P OF cursor_name 
						
	| /* empty */ 
						
	;

zone_value
	: Sconst 
						
	| IDENT 
						
	| ConstInterval Sconst opt_interval 
						
	| ConstInterval SQL_LP Iconst SQL_RP Sconst opt_interval 
						
	| NumericOnly 
						
	| DEFAULT 
						
	| LOCAL 
						
	;

TriggerOneEvent
	: INSERT 
						
	| DELETE_P 
						
	| UPDATE 
						
	| UPDATE OF columnList 
						
	| TRUNCATE 
						
	;

opt_set_data
	: SET DATA_P 
						
	| /* empty */ 
						
	;

RevokeStmt
	: REVOKE privileges ON privilege_target FROM grantee_list opt_drop_behavior 
						
	| REVOKE GRANT OPTION FOR privileges ON privilege_target FROM grantee_list opt_drop_behavior 
						
	;

opt_asc_desc
	: ASC 
						
	| DESC 
						
	| /* empty */ 
						
	;

VariableShowStmt
	: SHOW var_name 
						
	| SHOW TIME ZONE 
						
	| SHOW TRANSACTION ISOLATION LEVEL 
						
	| SHOW SESSION AUTHORIZATION 
						
	| SHOW ALL 
						
	;

privilege_target
	: qualified_name_list 
						
	| TABLE qualified_name_list 
						
	| SEQUENCE qualified_name_list 
						
	| FOREIGN DATA_P WRAPPER name_list 
						
	| FOREIGN SERVER name_list 
						
	| FUNCTION function_with_argtypes_list 
						
	| DATABASE name_list 
						
	| DOMAIN_P any_name_list 
						
	| LANGUAGE name_list 
						
	| LARGE_P OBJECT_P NumericOnly_list 
						
	| SCHEMA name_list 
						
	| TABLESPACE name_list 
						
	| TYPE_P any_name_list 
						
	| ALL TABLES IN_P SCHEMA name_list 
						
	| ALL SEQUENCES IN_P SCHEMA name_list 
						
	| ALL FUNCTIONS IN_P SCHEMA name_list 
						
	;

copy_options
	: copy_opt_list 
						
	| SQL_LP copy_generic_opt_list SQL_RP 
						
	;

DropUserStmt
	: DROP USER name_list 
						
	| DROP USER IF_P EXISTS name_list 
						
	;

RuleActionList
	: NOTHING 
						
	| RuleActionStmt 
						
	| SQL_LP RuleActionMulti SQL_RP 
						
	;

CreateOptRoleElem
	: AlterOptRoleElem 
						
	| SYSID Iconst 
						
	| ADMIN name_list 
						
	| ROLE name_list 
						
	| IN_P ROLE name_list 
						
	| IN_P GROUP_P name_list 
						
	;

AlterRoleStmt
	: ALTER ROLE RoleId opt_with AlterOptRoleList 
						
	;

opt_full
	: FULL 
						
	| /* empty */ 
						
	;

AlterDatabaseSetStmt
	: ALTER DATABASE database_name SetResetClause 
						
	;

CreateFunctionStmt
	: CREATE opt_or_replace FUNCTION func_name func_args_with_defaults RETURNS func_return createfunc_opt_list opt_definition 
						
	| CREATE opt_or_replace FUNCTION func_name func_args_with_defaults RETURNS TABLE SQL_LP table_func_column_list SQL_RP createfunc_opt_list opt_definition 
						
	| CREATE opt_or_replace FUNCTION func_name func_args_with_defaults createfunc_opt_list opt_definition 
						
	;

from_in
	: FROM 
						
	| IN_P 
						
	;

RevokeRoleStmt
	: REVOKE privilege_list FROM name_list opt_granted_by opt_drop_behavior 
						
	| REVOKE ADMIN OPTION FOR privilege_list FROM name_list opt_granted_by opt_drop_behavior 
						
	;

opt_concurrently
	: CONCURRENTLY 
						
	| /* empty */ 
						
	;

TableElementList
	: TableElement 
						
	| TableElementList SQL_COMMA TableElement 
						
	;

offset_clause
	: OFFSET select_offset_value 
						
	| OFFSET select_offset_value2 row_or_rows 
						
	;


opt_partition_clause
	: PARTITION BY expr_list 

	| /* empty */ 
						
	;

name
	: ColId 
						
	;

opt_in_database
	: /* empty */ 
						
	| IN_P DATABASE database_name 
						
	;

select_limit_value
	: a_expr 
						
	| ALL 
						
	;

TriggerForOptEach
	: EACH 
						
	| /* empty */ 
						
	;

generic_option_elem
	: generic_option_name generic_option_arg 
						
	;

ctext_expr
	: a_expr 
						
	| DEFAULT 
						
	;

opt_trusted
	: TRUSTED 
						
	| /* empty */ 
						
	;

select_offset_value2
	: c_expr 
						
	;

copy_generic_opt_arg_list_item
	: opt_boolean_or_string 
						
	;

expr_list
	: a_expr 
						
	| expr_list SQL_COMMA a_expr 
						
	;

AlterTSDictionaryStmt
	: ALTER TEXT_P SEARCH DICTIONARY any_name definition 
						
	;

DefACLAction
	: GRANT privileges ON defacl_privilege_target TO grantee_list opt_grant_grant_option 
						
	| REVOKE privileges ON defacl_privilege_target FROM grantee_list opt_drop_behavior 
						
	| REVOKE GRANT OPTION FOR privileges ON defacl_privilege_target FROM grantee_list opt_drop_behavior 
						
	;

DeallocateStmt
	: DEALLOCATE name 
						
	| DEALLOCATE PREPARE name 
						
	| DEALLOCATE ALL 
						
	| DEALLOCATE PREPARE ALL 
						
	;

copy_opt_item
	: BINARY 
						
	| OIDS 
						
	| DELIMITER opt_as Sconst 
						
	| NULL_P opt_as Sconst 
						
	| CSV 
						
	| HEADER_P 
						
	| QUOTE opt_as Sconst 
						
	| ESCAPE opt_as Sconst 
						
	| FORCE QUOTE columnList 
						
	| FORCE QUOTE SQL_MUL 
						
	| FORCE NOT NULL_P columnList 
						
	| ENCODING Sconst 
						
	;

type_func_name_keyword
	: AUTHORIZATION 
						
	| BINARY 
						
	| COLLATION 
						
	| CONCURRENTLY 
						
	| CROSS 
						
	| CURRENT_SCHEMA 
						
	| FREEZE 
						
	| FULL 
						
	| ILIKE 
						
	| INNER_P 
						
	| IS 
						
	| ISNULL 
						
	| JOIN 
						
	| LEFT 
						
	| LIKE 
						
	| NATURAL 
						
	| NOTNULL 
						
	| OUTER_P 
						
	| OVER 
						
	| OVERLAPS 
						
	| RIGHT 
						
	| SIMILAR 
						
	| VERBOSE 
						
	| INDEX 
								
	;

event
	: SELECT 
						
	| UPDATE 
						
	| DELETE_P 
						
	| INSERT 
						
	;

opclass_purpose
	: FOR SEARCH 
						
	| FOR ORDER BY any_name 
						
	| /* empty */ 
						
	;

explain_option_list
	: explain_option_elem 
						
	| explain_option_list SQL_COMMA explain_option_elem 
						
	;

opt_with
	: WITH 
						
	| /* empty */ 
						
	;

AlterForeignTableStmt
	: ALTER FOREIGN TABLE relation_expr alter_table_cmds 
						
	| ALTER FOREIGN TABLE IF_P EXISTS relation_expr alter_table_cmds 
						
	;

alter_using
	: USING a_expr 
						
	| /* empty */ 
						
	;

col_name_keyword
	: BETWEEN 
						
	| BIGINT 
						
	| BIT 
						
	| BOOLEAN_P 
						
	| CHAR_P 
						
	| CHARACTER 
						
	| COALESCE 
						
	| DEC 
						
	| DECIMAL_P 
						
	| EXISTS 
						
	| EXTRACT 
						
	| FLOAT_P 
						
	| GREATEST 
						
	| INOUT 
						
	| INT_P 
						
	| INTEGER 
						
	| INTERVAL 
						
	| LEAST 
						
	| NATIONAL 
						
	| NCHAR 
						
	| NONE 
						
	| NULLIF 
						
	| NUMERIC 
						
	| OUT_P 
						
	| OVERLAY 
						
	| POSITION 
						
	| PRECISION 
						
	| REAL 
						
	| ROW 
						
	| SETOF 
						
	| SMALLINT 
						
	| SUBSTRING 
						
	| TIME 
						
	| TIMESTAMP 
						
	| TREAT 
						
	| TRIM 
						
	| VALUES 
						
	| XMLATTRIBUTES 
						
	| XMLCONCAT 
						
	| XMLELEMENT 
						
	| XMLEXISTS 
						
	| XMLFOREST 
						
	| XMLPARSE 
						
	| XMLPI 
						
	| XMLROOT 
						
	| XMLSERIALIZE 
						
	| TD_GRAPHIC 
		// TODO4
	
	| TD_VARGRAPHIC 

	
	| TD_LONG 

	
	;

columnref
	: ColId 
						
	| ColId indirection 
						
	;

RoleId
	: ColId 
						
	;

DropCastStmt
	: DROP CAST opt_if_exists SQL_LP Typename AS Typename SQL_RP opt_drop_behavior 
						
	;

NumericOnly_list
	: NumericOnly 
						
	| NumericOnly_list SQL_COMMA NumericOnly 
						
	;

window_clause
	: WINDOW window_definition_list 
						
	| /* empty */ 
						
	;

ClusterStmt
	: CLUSTER opt_verbose qualified_name cluster_index_specification 
						
	| CLUSTER opt_verbose 
						
	| CLUSTER opt_verbose index_name ON qualified_name 
						
	;

Typename
	: SimpleTypename opt_array_bounds 
						
	| SETOF SimpleTypename opt_array_bounds 
						
	| SimpleTypename ARRAY SQL_LB Iconst SQL_RB 
						
	| SETOF SimpleTypename ARRAY SQL_LB Iconst SQL_RB 
						
	| SimpleTypename ARRAY 
						
	| SETOF SimpleTypename ARRAY 
						
	| FORMAT Sconst
						
	;

add_drop
	: ADD_P 
						
	| DROP 
						
	;

old_aggr_definition
	: SQL_LP old_aggr_list SQL_RP 
						
	;

ExclusionConstraintList
	: ExclusionConstraintElem 
						
	| ExclusionConstraintList SQL_COMMA ExclusionConstraintElem 
						
	;

opt_fdw_options
	: fdw_options 
						
	| /* empty */ 
						
	;

ColId
	: IDENT 
						
	| unreserved_keyword 
						
	| col_name_keyword 
						
	;

OptSchemaEltList
	: OptSchemaEltList schema_stmt 
						
	| /* empty */ 
						
	;

Numeric
	: INT_P 
						
	| INTEGER 
						
	| SMALLINT 
						
	| BIGINT 
						
	| REAL 
						
	| FLOAT_P opt_float 
						
	| DOUBLE_P PRECISION 
						
	| DECIMAL_P opt_type_modifiers 
						
	| DEC opt_type_modifiers 
						
	| NUMERIC opt_type_modifiers 
						
	| BOOLEAN_P 
						
	;

CharacterWithLength
	: character SQL_LP Iconst SQL_RP opt_charset 
						
	;

function_with_argtypes_list
	: function_with_argtypes 
						
	| function_with_argtypes_list SQL_COMMA function_with_argtypes 
						
	;

index_elem
	: ColId opt_collate opt_class opt_asc_desc opt_nulls_order 
						
	| func_expr opt_collate opt_class opt_asc_desc opt_nulls_order 
						
	| SQL_LP a_expr SQL_RP opt_collate opt_class opt_asc_desc opt_nulls_order 
						
	;

definition
	: SQL_LP def_list SQL_RP 
						
	;

SeqOptList
	: SeqOptElem 
						
	| SeqOptList SeqOptElem 
						
	;

enum_val_list
	: Sconst 
						
	| enum_val_list SQL_COMMA Sconst 
						
	;

opt_select_limit
	: select_limit 
						
	| /* empty */ 
						
	;

qualified_name_list
	: qualified_name 
						
	| qualified_name_list SQL_COMMA qualified_name 
						
	;

alter_table_cmds
	: alter_table_cmd 
						
	| alter_table_cmds SQL_COMMA alter_table_cmd 
						
	;

DropOpFamilyStmt
	: DROP OPERATOR FAMILY any_name USING access_method opt_drop_behavior 
						
	| DROP OPERATOR FAMILY IF_P EXISTS any_name USING access_method opt_drop_behavior 
						
	;

RuleActionMulti
	: RuleActionMulti SQL_SEMI RuleActionStmtOrEmpty 
						
	| RuleActionStmtOrEmpty 
						
	;

aggr_args
	: SQL_LP type_list SQL_RP 
						
	| SQL_LP SQL_MUL SQL_RP 
						
	;

def_arg
	: func_type 
						
	| reserved_keyword 
						
	| qual_all_Op 
						
	| NumericOnly 
						
	| Sconst 
						
	;

explain_option_elem
	: explain_option_name explain_option_arg 
						
	;

func_arg
	: arg_class param_name func_type 
						
	| param_name arg_class func_type 
						
	| param_name func_type 
						
	| arg_class func_type 
						
	| func_type 
						
	;

opt_inline_handler
	: INLINE_P handler_name 
						
	| /* empty */ 
						
	;

opt_no_inherit
	: NO INHERIT 
						
	| /* empty */ 
						
	;

opt_procedural
	: PROCEDURAL 
						
	| /* empty */ 
						
	;

insert_rest
	: SelectStmt 
						
	| SQL_LP insert_column_list SQL_RP SelectStmt 
						
	| DEFAULT VALUES 
						
	;

fdw_options
	: fdw_option 
						
	| fdw_options fdw_option 
						
	;

DeleteStmt
	: opt_with_clause DELETE_P FROM relation_expr_opt_alias_list using_clause where_or_current_clause returning_clause 
						
	| opt_with_clause DELETE_P relation_expr_opt_alias_list using_clause where_or_current_clause returning_clause 
								
	| opt_with_clause DELETE_P relation_expr_opt_alias FROM relation_expr_opt_alias_list using_clause where_or_current_clause returning_clause 
						
	;

TriggerForType
	: ROW 
						
	| STATEMENT 
						
	;

DropRoleStmt
	: DROP ROLE name_list 
						
	| DROP ROLE IF_P EXISTS name_list 
						
	;

generic_option_arg
	: Sconst 
						
	;

FetchStmt
	: FETCH fetch_args 
						
	| MOVE fetch_args 
						
	;

opt_class
	: any_name 
						
	| USING any_name 
						
	| /* empty */ 
						
	;

constraints_set_mode
	: DEFERRED 
						
	| IMMEDIATE 
						
	;

any_name_list
	: any_name 
						
	| any_name_list SQL_COMMA any_name 
						
	;

access_method
	: ColId 
						
	;

TableConstraint
	: CONSTRAINT name ConstraintElem 
						
	| ConstraintElem 
						
	;

RuleActionStmt
	: SelectStmt 
						
	| InsertStmt 
						
	| UpdateStmt 
						
	| DeleteStmt 
						
	| NotifyStmt 
						
	;

ConstCharacter
	: CharacterWithLength 
						
	| CharacterWithoutLength 
						
	;

join_qual
	: USING SQL_LP name_list SQL_RP 
						
	| ON a_expr 
						
	;

LockStmt
	: LOCK_P opt_table relation_expr_list opt_lock opt_nowait 
						
	;

TableFuncElementList
	: TableFuncElement 
						
	| TableFuncElementList SQL_COMMA TableFuncElement 
						
	;


target_el
	: a_expr AS ColLabel sample_clause 
						
	| a_expr IDENT sample_clause 
						
	| a_expr sample_clause 
						
	| SQL_MUL 
						
	| a_expr AS Sconst 
								
	;

validator_clause
	: VALIDATOR handler_name 
						
	| NO VALIDATOR 
						
	;

function_with_argtypes
	: func_name func_args 
						
	;

opt_float
	: SQL_LP Iconst SQL_RP 
						
	| /* empty */ 
						
	;

alias_clause
	: AS ColId SQL_LP name_list SQL_RP 
						
	| AS ColId 
						
	| ColId SQL_LP name_list SQL_RP 
						
	| ColId 
						
	;

func_args
	: SQL_LP func_args_list SQL_RP 
						
	| SQL_LP SQL_RP 
						
	;

case_expr
	: CASE case_arg when_clause_list case_default END_P 
						
	;

file_name
	: Sconst 
						
	;

for_locking_items
	: for_locking_item 
						
	| for_locking_items for_locking_item 
						
	;

multiple_set_clause
	: SQL_LP set_target_list SQL_RP SQL_EQ ctext_row 
						
	;

opt_force
	: FORCE 
						
	| /* empty */ 
						
	;

group_clause
	: GROUP_P BY expr_list 
						
	| GROUP_P BY TD_GROUPING TD_SETS expr_list 
								
	| /* empty */ 
						
	;

opt_alias_clause
	: alias_clause 
						
	| /* empty */ 
						
	;

createfunc_opt_item
	: AS func_as 
						
	| LANGUAGE ColId_or_Sconst 
						
	| WINDOW 
						
	| common_func_opt_item 
						
	;

opt_recheck
	: RECHECK 
						
	| /* empty */ 
						
	;

TypedTableElement
	: columnOptions 
						
	| TableConstraint 
						
	;

OptTableFuncElementList
	: TableFuncElementList 
						
	| /* empty */ 
						
	;

CreatePLangStmt
	: CREATE opt_or_replace opt_trusted opt_procedural LANGUAGE ColId_or_Sconst 
						
	| CREATE opt_or_replace opt_trusted opt_procedural LANGUAGE ColId_or_Sconst HANDLER handler_name opt_inline_handler opt_validator 
						
	;

AlterCompositeTypeStmt
	: ALTER TYPE_P any_name alter_type_cmds 
						
	;

AlterEnumStmt
	: ALTER TYPE_P any_name ADD_P VALUE_P Sconst 
						
	| ALTER TYPE_P any_name ADD_P VALUE_P Sconst BEFORE Sconst 
						
	| ALTER TYPE_P any_name ADD_P VALUE_P Sconst AFTER Sconst 
						
	;

func_type
	: Typename 
						
	| type_function_name attrs SQL_MOD TYPE_P 
						
	| SETOF type_function_name attrs SQL_MOD TYPE_P 
						
	;

copy_delimiter
	: opt_using DELIMITERS Sconst 
						
	| /* empty */ 
						
	;

CheckPointStmt
	: CHECKPOINT 
						
	;

opt_all
	: ALL 
						
	| DISTINCT 
						
	| /* empty */ 
						
	;

key_actions
	: key_update 
						
	| key_delete 
						
	| key_update key_delete 
						
	| key_delete key_update 
						
	| /* empty */ 
						
	;

CreateOpFamilyStmt
	: CREATE OPERATOR FAMILY any_name USING access_method 
						
	;

opt_column_list
	: SQL_LP columnList SQL_RP 
						
	| /* empty */ 
						
	;

ListenStmt
	: LISTEN ColId 
						
	;

OptConstrFromTable
	: FROM qualified_name 
						
	| /* empty */ 
						
	;

window_specification
	: SQL_LP opt_existing_window_name opt_partition_clause opt_sort_clause opt_frame_clause SQL_RP 
						
	;

values_clause
	: VALUES ctext_row 
						
	| values_clause SQL_COMMA ctext_row 
						
	;

BitWithLength
	: BIT opt_varying SQL_LP expr_list SQL_RP 
						
	;

from_list
	: table_ref 
						
	| from_list SQL_COMMA table_ref 
						
	;

AlterDefaultPrivilegesStmt
	: ALTER DEFAULT PRIVILEGES DefACLOptionList DefACLAction 
						
	;

Character_BIG
	: CharacterWithLength 
						
	| CharacterWithoutLength 
						
	;

RemoveOperStmt
	: DROP OPERATOR any_operator oper_argtypes opt_drop_behavior 
						
	| DROP OPERATOR IF_P EXISTS any_operator oper_argtypes opt_drop_behavior 
						
	;

AlterObjectSchemaStmt
	: ALTER AGGREGATE func_name aggr_args SET SCHEMA name 
						
	| ALTER COLLATION any_name SET SCHEMA name 
						
	| ALTER CONVERSION_P any_name SET SCHEMA name 
						
	| ALTER DOMAIN_P any_name SET SCHEMA name 
						
	| ALTER EXTENSION any_name SET SCHEMA name 
						
	| ALTER FUNCTION function_with_argtypes SET SCHEMA name 
						
	| ALTER OPERATOR any_operator oper_argtypes SET SCHEMA name 
						
	| ALTER OPERATOR CLASS any_name USING access_method SET SCHEMA name 
						
	| ALTER OPERATOR FAMILY any_name USING access_method SET SCHEMA name 
						
	| ALTER TABLE relation_expr SET SCHEMA name 
						
	| ALTER TABLE IF_P EXISTS relation_expr SET SCHEMA name 
						
	| ALTER TEXT_P SEARCH PARSER any_name SET SCHEMA name 
						
	| ALTER TEXT_P SEARCH DICTIONARY any_name SET SCHEMA name 
						
	| ALTER TEXT_P SEARCH TEMPLATE any_name SET SCHEMA name 
						
	| ALTER TEXT_P SEARCH CONFIGURATION any_name SET SCHEMA name 
						
	| ALTER SEQUENCE qualified_name SET SCHEMA name 
						
	| ALTER SEQUENCE IF_P EXISTS qualified_name SET SCHEMA name 
						
	| ALTER VIEW qualified_name SET SCHEMA name 
						
	| ALTER VIEW IF_P EXISTS qualified_name SET SCHEMA name 
						
	| ALTER FOREIGN TABLE relation_expr SET SCHEMA name 
						
	| ALTER FOREIGN TABLE IF_P EXISTS relation_expr SET SCHEMA name 
						
	| ALTER TYPE_P any_name SET SCHEMA name 
						
	;

sortby_list
	: sortby 
						
	| sortby_list SQL_COMMA sortby 
						
	;

ColConstraintElem
	: NOT NULL_P 
						
	| NULL_P 
						
	| UNIQUE opt_definition OptConsTableSpace 
						
	| PRIMARY KEY opt_definition OptConsTableSpace 
						
	| CHECK SQL_LP a_expr SQL_RP opt_no_inherit 
						
	| DEFAULT b_expr 
						
	| REFERENCES qualified_name opt_column_list key_match key_actions 
						
	;

reindex_type
	: INDEX 
						
	| TABLE 
						
	;

CreateSeqStmt
	: CREATE OptTemp SEQUENCE qualified_name OptSeqOptList 
						
	;

CreateCastStmt
	: CREATE CAST SQL_LP Typename AS Typename SQL_RP WITH FUNCTION function_with_argtypes cast_context 
						
	| CREATE CAST SQL_LP Typename AS Typename SQL_RP WITHOUT FUNCTION cast_context 
						
	| CREATE CAST SQL_LP Typename AS Typename SQL_RP WITH INOUT cast_context 
						
	;

auth_ident
	: CURRENT_USER 
						
	| USER 
						
	| RoleId 
						
	;

substr_from
	: FROM a_expr 
						
	;

unreserved_keyword
	: ABORT_P 
						
	| ABSOLUTE_P 
						
	| ACCESS 
						
	| ACTION 
						
	| ADD_P 
						
	| ADMIN 
						
	| AFTER 
						
	| AGGREGATE 
						
	| ALSO 
						
	| ALTER 
						
	| ALWAYS 
						
	| ASSERTION 
						
	| ASSIGNMENT 
						
	| AT 
						
	| ATTRIBUTE 
						
	| BACKWARD 
						
	| BEFORE 
						
	| BEGIN_P 
						
	| BY 
						
	| CACHE 
						
	| CALLED 
						
	| CASCADE 
						
	| CASCADED 
						
	| CATALOG_P 
						
	| CHAIN 
						
	| CHARACTERISTICS 
						
	| CHECKPOINT 
						
	| CLASS 
						
	| CLOSE 
						
	| CLUSTER 
						
	| COMMENT 
						
	| COMMENTS 
						
	| COMMIT 
						
	| COMMITTED 
						
	| CONFIGURATION 
						
	| CONNECTION 
						
	| CONSTRAINTS 
						
	| CONTENT_P 
						
	| CONTINUE_P 
						
	| CONVERSION_P 
						
	| COPY 
						
	| COST 
						
	| CSV 
						
	| CURRENT_P 
						
	| CURSOR 
						
	| CYCLE 
						
	| DATA_P 
						
	| DATABASE 
						
	| DAY_P 
						
	| DEALLOCATE 
						
	| DECLARE 
						
	| DEFAULTS 
						
	| DEFERRED 
						
	| DEFINER 
						
	| DELETE_P 
						
	| DELIMITER 
						
	| DELIMITERS 
						
	| DICTIONARY 
						
	| DISABLE_P 
						
	| DISCARD 
						
	| DOCUMENT_P 
						
	| DOMAIN_P 
						
	| DOUBLE_P 
						
	| DROP 
						
	| EACH 
						
	| ENABLE_P 
						
	| ENCODING 
						
	| ENCRYPTED 
						
	| ENUM_P 
						
	| ESCAPE 
						
	| EXCLUDE 
						
	| EXCLUDING 
						
	| EXCLUSIVE 
						
	| EXECUTE 
						
	| EXPLAIN 
						
	| EXTENSION 
						
	| EXTERNAL 
						
	| FAMILY 
						
	| FIRST_P 
						
	| FOLLOWING 
						
	| FORCE 
						
	| FORWARD 
						
	| FUNCTION 
						
	| FUNCTIONS 
						
	| GLOBAL 
						
	| GRANTED 
						
	| HANDLER 
						
	| HEADER_P 
						
	| HOLD 
						
	| HOUR_P 
						
	| IDENTITY_P 
						
	| IF_P 
						
	| IMMEDIATE 
						
	| IMMUTABLE 
						
	| IMPLICIT_P 
						
	| INCLUDING 
						
	| INCREMENT 

	| INDEXES 
						
	| INHERIT 
						
	| INHERITS 
						
	| INLINE_P 
						
	| INPUT_P 
						
	| INSENSITIVE 
						
	| INSERT 
						
	| INSTEAD 
						
	| INVOKER 
						
	| ISOLATION 
						
	| KEY 
						
	| LABEL 
						
	| LANGUAGE 
						
	| LARGE_P 
						
	| LAST_P 
						
	| LC_COLLATE_P 
						
	| LC_CTYPE_P 
						
	| LEAKPROOF 
						
	| LEVEL 
						
	| LISTEN 
						
	| LOAD 
						
	| LOCAL 
						
	| LOCATION 
						
	| LOCK_P 
						
	| MAPPING 
						
	| MATCH 
						
	| MAXVALUE 
						
	| MINUTE_P 
						
	| MINVALUE 
						
	| MODE 
						
	| MONTH_P 
						
	| MOVE 
						
	| NAME_P 
						
	| NAMES 
						
	| NEXT 
						
	| NO 
						
	| NOTHING 
						
	| NOTIFY 
						
	| NOWAIT 
						
	| NULLS_P 
						
	| OBJECT_P 
						
	| OF 
						
	| OFF 
						
	| OIDS 
						
	| OPERATOR 
						
	| OPTION 
						
	| OPTIONS 
						
	| OWNED 
						
	| OWNER 
						
	| PARSER 
						
	| PARTIAL 
						
	| PARTITION 
						
	| PASSING 
						
	| PASSWORD 
						
	| PLANS 
						
	| PRECEDING 
						
	| PREPARE 
						
	| PREPARED 
						
	| PRESERVE 
						
	| PRIOR 
						
	| PRIVILEGES 
						
	| PROCEDURAL 
						
	| PROCEDURE 
						
	| QUOTE 
						
	| RANGE 
						
	| READ 
						
	| REASSIGN 
						
	| RECHECK 
						
	| RECURSIVE 
						
	| REF 
						
	| REINDEX 
						
	| RELATIVE_P 
						
	| RELEASE 
						
	| RENAME 
						
	| REPEATABLE 
						
	| REPLACE 
						
	| REPLICA 
						
	| RESET 
						
	| RESTART 
						
	| RESTRICT 
						
	| RETURNS 
						
	| REVOKE 
						
	| ROLE 
						
	| ROLLBACK 
						
	| ROWS 
						
	| RULE 
						
	| SAVEPOINT 
						
	| SCHEMA 
						
	| SCROLL 
						
	| SEARCH 
						
	| SECOND_P 
						
	| SECURITY 
						
	| SEQUENCE 
						
	| SEQUENCES 
						
	| SERIALIZABLE 
						
	| SERVER 
						
	| SESSION 
						
	| SHARE 
						
	| SHOW 
						
	| SIMPLE 
						
	| SNAPSHOT 
						
	| STABLE 
						
	| STANDALONE_P 
						
	| START 
						
	| STATEMENT 
						
	| STATISTICS 
						
	| STDIN 
						
	| STDOUT 
						
	| STORAGE 
						
	| STRICT_P 
						
	| STRIP_P 
						
	| SYSID 
						
	| SYSTEM_P 
						
	| TABLES 
						
	| TABLESPACE 
						
	| TEMP 
						
	| TEMPLATE 
						
	| TEMPORARY 
						
	| TEXT_P 
						
	| TRANSACTION 
						
	| TRIGGER 
						
	| TRUNCATE 
						
	| TRUSTED 
						
	| TYPE_P 
						
	| TYPES_P 
						
	| UNBOUNDED 
						
	| UNCOMMITTED 
						
	| UNENCRYPTED 
						
	| UNKNOWN 
						
	| UNLISTEN 
						
	| UNLOGGED 
						
	| UNTIL 
						
	| UPDATE 
						
	| VACUUM 
						
	| VALID 
						
	| VALIDATE 
						
	| VALIDATOR 
						
	| VALUE_P 
						
	| VARYING 
						
	| VERSION_P 
						
	| VIEW 
						
	| VOLATILE 
						
	| WHITESPACE_P 
						
	| WITHOUT 
						
	| WORK 
						
	| WRAPPER 
						
	| WRITE 
						
	| XML_P 
						
	| YEAR_P 
						
	| YES_P 
						
	| ZONE 
						
	| TD_FALLBACK 
								
	| TD_PROTECTION 
						
	| TD_LOG 
						
	| TD_CHECKSUM 
						
	| TD_FREESPACE 
						
	| TD_JOURNAL 
						
	| TD_DUAL 
						
	| TD_PERCENT 
						
	| EVENT 
						
	| FORMAT 
								
	| TD_MERGEBLOCKRATIO 
								
	;

document_or_content
	: DOCUMENT_P 
						
	| CONTENT_P 
						
	;

Bit
	: BitWithLength 
						
	| BitWithoutLength 
						
	;

alter_generic_options
	: OPTIONS SQL_LP alter_generic_option_list SQL_RP 
						
	;

opt_nulls_order
	: NULLS_FIRST 
						
	| NULLS_LAST 
						
	| /* empty */ 
						
	;

opt_default
	: DEFAULT 
						
	| /* empty */ 
						
	;

first_or_next
	: FIRST_P 
						
	| NEXT 
						
	;

old_aggr_elem
	: IDENT SQL_EQ def_arg 
						
	;

opt_collate_clause
	: COLLATE any_name 
						
	| /* empty */ 
						
	;

TruncateStmt
	: TRUNCATE opt_table relation_expr_list opt_restart_seqs opt_drop_behavior 
						
	;

alterfunc_opt_list
	: common_func_opt_item 
						
	| alterfunc_opt_list common_func_opt_item 
						
	;

attr_name
	: ColLabel 
						
	;

alter_extension_opt_list
	: alter_extension_opt_list alter_extension_opt_item 
						
	| /* empty */ 
						
	;

PrepareStmt
	: PREPARE name prep_type_clause AS PreparableStmt 
						
	;

oper_argtypes
	: SQL_LP Typename SQL_RP 
						
	| SQL_LP Typename SQL_COMMA Typename SQL_RP 
						
	| SQL_LP NONE SQL_COMMA Typename SQL_RP 
						
	| SQL_LP Typename SQL_COMMA NONE SQL_RP 
						
	;

DiscardStmt
	: DISCARD ALL 
						
	| DISCARD TEMP 
						
	| DISCARD TEMPORARY 
						
	| DISCARD PLANS 
						
	;



CreateSysOptionList
	: CreateSysOptionList SQL_COMMA CreateSysOption 
								
	| /* empty */
	;
						

fallback_option
	: TD_FALLBACK 
								
	| NO TD_FALLBACK 
						
	| TD_FALLBACK TD_PROTECTION 
						
	| NO TD_FALLBACK TD_PROTECTION 
	
	;
log_option 
	: NO TD_LOG 
								
	| TD_LOG 
						
	
	;


freespace_option
	: TD_FREESPACE SQL_EQ Iconst 
								
	| TD_FREESPACE SQL_EQ Iconst TD_PERCENT 
						
	;

journal_option
	: TD_JOURNAL 
								
	| BEFORE TD_JOURNAL 
						
	| NO TD_JOURNAL 
						
	| TD_DUAL TD_JOURNAL 
						
	| NO BEFORE TD_JOURNAL 
						
	| TD_DUAL BEFORE TD_JOURNAL 
						
	| AFTER TD_JOURNAL 
						
	| NO AFTER TD_JOURNAL 
						
	| TD_DUAL AFTER TD_JOURNAL 
						
	| LOCAL AFTER TD_JOURNAL 
						
	| NOT LOCAL AFTER TD_JOURNAL 
						
	;

CreateSysOption
	: TD_CHECKSUM SQL_EQ DEFAULT 
								
	| fallback_option 
						
	| log_option 
						
	| freespace_option 
						
	| journal_option 
						
	| DEFAULT TD_MERGEBLOCKRATIO 
						
	;

CreateStmt
	: CREATE OptSetMultiset OptTemp TABLE qualified_name CreateSysOptionList SQL_LP OptTableElementList SQL_RP OptInherit OptWith opt_index_definition opt_partition_clause OnCommitOption 
						
	| CREATE OptSetMultiset OptTemp TABLE IF_P NOT EXISTS qualified_name CreateSysOptionList SQL_LP OptTableElementList SQL_RP OptInherit OptWith opt_index_definition opt_partition_clause OnCommitOption 
						
	| CREATE OptSetMultiset OptTemp TABLE qualified_name OF any_name OptTypedTableElementList OptWith opt_index_definition opt_partition_clause OnCommitOption 
						
	| CREATE OptSetMultiset OptTemp TABLE IF_P NOT EXISTS qualified_name OF any_name OptTypedTableElementList OptWith opt_index_definition opt_partition_clause OnCommitOption 
						
	| CREATE OptTemp TABLE qualified_name SQL_LP OptTableElementList SQL_RP OptInherit OptWith opt_index_definition opt_partition_clause OnCommitOption 
						
	| CREATE OptTemp TABLE IF_P NOT EXISTS qualified_name SQL_LP OptTableElementList SQL_RP OptInherit OptWith opt_index_definition opt_partition_clause OnCommitOption 
						
	| CREATE OptTemp TABLE qualified_name OF any_name OptTypedTableElementList OptWith opt_index_definition opt_partition_clause OnCommitOption 
						
	| CREATE OptTemp TABLE IF_P NOT EXISTS qualified_name OF any_name OptTypedTableElementList OptWith opt_index_definition opt_partition_clause OnCommitOption 
						
	| CREATE OptTemp TABLE qualified_name CreateSysOptionList SQL_COMMA CreateSysOption SQL_LP OptTableElementList SQL_RP OptInherit OptWith opt_index_definition opt_partition_clause OnCommitOption 
						
	| CREATE OptTemp TABLE IF_P NOT EXISTS qualified_name CreateSysOptionList SQL_COMMA CreateSysOption SQL_LP OptTableElementList SQL_RP OptInherit OptWith opt_index_definition opt_partition_clause OnCommitOption 
						
	;

security_label_type
	: COLUMN 
						
	| DATABASE 
						
	| EVENT TRIGGER 
						
	| FOREIGN TABLE 
						
	| SCHEMA 
						
	| SEQUENCE 
						
	| TABLE 
						
	| DOMAIN_P 
						
	| ROLE 
						
	| TABLESPACE 
						
	| TYPE_P 
						
	| VIEW 
						
	;

all_Op
	: Op 
						
	| MathOp 
						
	;

func_arg_expr
	: a_expr 
						
	| param_name COLON_EQUALS a_expr 
						
	| CharacterWithLength 
						
	;

CreateConversionStmt
	: CREATE opt_default CONVERSION_P any_name FOR Sconst TO Sconst FROM any_name 
						
	;

func_args_with_defaults
	: SQL_LP func_args_with_defaults_list SQL_RP 
						
	| SQL_LP SQL_RP 
						
	;

AlterUserMappingStmt
	: ALTER USER MAPPING FOR auth_ident SERVER name alter_generic_options 
						
	;

TableLikeOptionList
	: TableLikeOptionList INCLUDING TableLikeOption 
						
	| TableLikeOptionList EXCLUDING TableLikeOption 
						
	| /* empty */ 
						
	;

ExclusionWhereClause
	: WHERE SQL_LP a_expr SQL_RP 
						
	| /* empty */ 
						
	;

ConstraintsSetStmt
	: SET CONSTRAINTS constraints_set_list constraints_set_mode 
						
	;

opt_grant_admin_option
	: WITH ADMIN OPTION 
						
	| /* empty */ 
						
	;

opt_type_modifiers
	: SQL_LP expr_list SQL_RP 
						
	| /* empty */ 
						
	;

ConstBit
	: BitWithLength 
						
	| BitWithoutLength 
						
	;

CreateEventTrigStmt
	: CREATE EVENT TRIGGER name ON ColLabel EXECUTE PROCEDURE func_name SQL_LP SQL_RP 
						
	| CREATE EVENT TRIGGER name ON ColLabel WHEN event_trigger_when_list EXECUTE PROCEDURE func_name SQL_LP SQL_RP 
						
	;

set_target_list
	: set_target 
						
	| set_target_list SQL_COMMA set_target 
						
	;

overlay_list
	: a_expr overlay_placing substr_from substr_for 
						
	| a_expr overlay_placing substr_from 
						
	;

func_table
	: func_expr 
						
	;

CreateUserMappingStmt
	: CREATE USER MAPPING FOR auth_ident SERVER name create_generic_options 
						
	;

AlterFunctionStmt
	: ALTER FUNCTION function_with_argtypes alterfunc_opt_list opt_restrict 
						
	;

opt_as
	: AS 
						
	| /* empty */ 
						
	;

single_set_clause
	: set_target SQL_EQ ctext_expr 
						
	;

paren_func_expr 
	: func_name SQL_LP SQL_RP over_clause 
						
	| func_name SQL_LP func_arg_list SQL_RP over_clause 
						
	| func_name SQL_LP VARIADIC func_arg_expr SQL_RP over_clause 
						
	| func_name SQL_LP func_arg_list SQL_COMMA VARIADIC func_arg_expr SQL_RP over_clause 
						
	| func_name SQL_LP func_arg_list sort_clause SQL_RP over_clause 
						
	| func_name SQL_LP ALL func_arg_list opt_sort_clause SQL_RP over_clause 
						
	| func_name SQL_LP DISTINCT func_arg_list opt_sort_clause SQL_RP over_clause 
						
	| func_name SQL_LP SQL_MUL SQL_RP over_clause 
						
	| COLLATION FOR SQL_LP a_expr SQL_RP 
						
	| CURRENT_TIME SQL_LP Iconst SQL_RP 
						
	| CURRENT_TIMESTAMP SQL_LP Iconst SQL_RP 
						
	| LOCALTIME SQL_LP Iconst SQL_RP 
						
	| LOCALTIMESTAMP SQL_LP Iconst SQL_RP 
						
	| CAST SQL_LP a_expr AS Typename SQL_RP 
						
	| EXTRACT SQL_LP extract_list SQL_RP 
						
	| OVERLAY SQL_LP overlay_list SQL_RP 
						
	| POSITION SQL_LP position_list SQL_RP 
						
	| SUBSTRING SQL_LP substr_list SQL_RP 
						
	| TREAT SQL_LP a_expr AS Typename SQL_RP 
						
	| TRIM SQL_LP BOTH trim_list SQL_RP 
						
	| TRIM SQL_LP LEADING trim_list SQL_RP 
						
	| TRIM SQL_LP TRAILING trim_list SQL_RP 
						
	| TRIM SQL_LP trim_list SQL_RP 
						
	| NULLIF SQL_LP a_expr SQL_COMMA a_expr SQL_RP 
						
	| COALESCE SQL_LP expr_list SQL_RP 
						
	| GREATEST SQL_LP expr_list SQL_RP 
						
	| LEAST SQL_LP expr_list SQL_RP 
						
	| MAX_FUNC SQL_LP a_expr SQL_RP over_clause 
						
	| SUM_FUNC SQL_LP a_expr SQL_RP over_clause 
						
	| MIN_FUNC SQL_LP a_expr SQL_RP over_clause 
						
	| TRANSLATE_CHK SQL_LP any_name USING TranslationsTypes SQL_RP 
								
	| TRANSLATE SQL_LP any_name USING TranslationsTypes WITH ERROR_P SQL_RP 
								
	| TRANSLATE SQL_LP any_name USING TranslationsTypes SQL_RP 
						
	| SQL_MOD SQL_LP a_expr SQL_COMMA a_expr SQL_RP 
								
	;

func_expr
	: func_name SQL_LP SQL_RP over_clause 
						
	| func_name SQL_LP func_arg_list SQL_RP over_clause 
						
	| func_name SQL_LP VARIADIC func_arg_expr SQL_RP over_clause 
						
	| func_name SQL_LP func_arg_list SQL_COMMA VARIADIC func_arg_expr SQL_RP over_clause 
						
	| func_name SQL_LP func_arg_list sort_clause SQL_RP over_clause 
						
	| func_name SQL_LP ALL func_arg_list opt_sort_clause SQL_RP over_clause 
						
	| func_name SQL_LP DISTINCT func_arg_list opt_sort_clause SQL_RP over_clause 
						
	| func_name SQL_LP SQL_MUL SQL_RP over_clause 
						
	| COLLATION FOR SQL_LP a_expr SQL_RP 
						
	| CURRENT_DATE 
						
	| CURRENT_TIME 
						
	| CURRENT_TIME SQL_LP Iconst SQL_RP 
						
	| CURRENT_TIMESTAMP 
						
	| CURRENT_TIMESTAMP SQL_LP Iconst SQL_RP 
						
	| LOCALTIME 
						
	| LOCALTIME SQL_LP Iconst SQL_RP 
						
	| LOCALTIMESTAMP 
						
	| LOCALTIMESTAMP SQL_LP Iconst SQL_RP 
						
	| CURRENT_ROLE 
						
	| CURRENT_USER 
						
	| SESSION_USER 
						
	| USER 
						
	| CURRENT_CATALOG 
						
	| CURRENT_SCHEMA 
						
	| CAST SQL_LP a_expr AS Typename SQL_RP 
						
	| EXTRACT SQL_LP extract_list SQL_RP 
						
	| OVERLAY SQL_LP overlay_list SQL_RP 
						
	| POSITION SQL_LP position_list SQL_RP 
						
	| SUBSTRING SQL_LP substr_list SQL_RP 
						
	| TREAT SQL_LP a_expr AS Typename SQL_RP 
						
	| TRIM SQL_LP BOTH trim_list SQL_RP 
						
	| TRIM SQL_LP LEADING trim_list SQL_RP 
						
	| TRIM SQL_LP TRAILING trim_list SQL_RP 
						
	| TRIM SQL_LP trim_list SQL_RP 
						
	| NULLIF SQL_LP a_expr SQL_COMMA a_expr SQL_RP 
						
	| COALESCE SQL_LP expr_list SQL_RP 
						
	| GREATEST SQL_LP expr_list SQL_RP 
						
	| LEAST SQL_LP expr_list SQL_RP 
						
	| XMLCONCAT SQL_LP expr_list SQL_RP 
						
	| XMLELEMENT SQL_LP NAME_P ColLabel SQL_RP 
						
	| XMLELEMENT SQL_LP NAME_P ColLabel SQL_COMMA xml_attributes SQL_RP 
						
	| XMLELEMENT SQL_LP NAME_P ColLabel SQL_COMMA expr_list SQL_RP 
						
	| XMLELEMENT SQL_LP NAME_P ColLabel SQL_COMMA xml_attributes SQL_COMMA expr_list SQL_RP 
						
	| XMLEXISTS SQL_LP c_expr xmlexists_argument SQL_RP 
						
	| XMLFOREST SQL_LP xml_attribute_list SQL_RP 
						
	| XMLPARSE SQL_LP document_or_content a_expr xml_whitespace_option SQL_RP 
						
	| XMLPI SQL_LP NAME_P ColLabel SQL_RP 
						
	| XMLPI SQL_LP NAME_P ColLabel SQL_COMMA a_expr SQL_RP 
						
	| XMLROOT SQL_LP a_expr SQL_COMMA xml_root_version opt_xml_root_standalone SQL_RP 
						
	| XMLSERIALIZE SQL_LP document_or_content a_expr AS SimpleTypename SQL_RP 
						
	| MAX_FUNC SQL_LP a_expr SQL_RP over_clause 
						
	| SUM_FUNC SQL_LP a_expr SQL_RP over_clause 
						
	
	| MIN_FUNC SQL_LP a_expr SQL_RP over_clause 
						
	 
	| TRANSLATE_CHK SQL_LP any_name USING TranslationsTypes SQL_RP 
								
	| TRANSLATE SQL_LP any_name USING TranslationsTypes WITH ERROR_P SQL_RP 
								
	| TRANSLATE SQL_LP any_name USING TranslationsTypes SQL_RP 
								
	| TD_DATE 
						
	| DATETIME 			
	
	| SQL_MOD SQL_LP a_expr SQL_COMMA a_expr SQL_RP 
								
	| func_name SQL_LP DECIMAL_P SQL_LP expr_list SQL_RP SQL_RP 
						
	| Iconst SQL_LP DECIMAL_P SQL_LP expr_list SQL_RP SQL_RP 
						
	;

opclass_drop
	: OPERATOR Iconst SQL_LP type_list SQL_RP 
						
	| FUNCTION Iconst SQL_LP type_list SQL_RP 
						
	;

AexprConst
	: Iconst 
						
	| FCONST 
						
	| Sconst 
						
	| BCONST 
						
	| XCONST 
						
	| func_name Sconst 
						
	| func_name SQL_LP func_arg_list SQL_RP Sconst 
						
	| ConstTypename Sconst 
						
	| ConstInterval Sconst opt_interval 
						
	| ConstInterval SQL_LP Iconst SQL_RP Sconst opt_interval 
						
	| TRUE_P 
						
	| FALSE_P 
						
	| NULL_P 
						
	;

xml_attributes
	: XMLATTRIBUTES SQL_LP xml_attribute_list SQL_RP 
						
	;

ReassignOwnedStmt
	: REASSIGN OWNED BY name_list TO name 
						
	;

access_method_clause
	: USING access_method 
						
	| /* empty */ 
						
	;

copy_generic_opt_list
	: copy_generic_opt_elem 
						
	| copy_generic_opt_list SQL_COMMA copy_generic_opt_elem 
						
	;

columnList
	: columnElem 
						
	| columnList SQL_COMMA columnElem 
						
	;

TypedTableElementList
	: TypedTableElement 
						
	| TypedTableElementList SQL_COMMA TypedTableElement 
						
	;

opt_varying
	: VARYING 
						
	| /* empty */ 
						
	;

a_expr
	: c_expr 
						
	| a_expr SQL_TYPECAST Typename 
						
	| a_expr COLLATE any_name 
						
	| a_expr AT TIME ZONE a_expr %prec AT 
						
	| SQL_PLUS a_expr %prec UMINUS 
						
	| SQL_MINUS a_expr %prec UMINUS 
						
	| a_expr SQL_PLUS a_expr 
						
	| a_expr SQL_MINUS a_expr 
						
	| a_expr SQL_MUL a_expr 
						
	| a_expr SQL_DIV a_expr 
						
	| a_expr SQL_MOD a_expr 
						
	| a_expr SQL_POWER a_expr 
						
	| a_expr SQL_LT a_expr 
						
	| a_expr SQL_GT a_expr 
						
	| a_expr SQL_EQ a_expr 
						
	| a_expr qual_Op a_expr %prec Op 
						
	| qual_Op a_expr %prec Op 
						
	| a_expr qual_Op %prec POSTFIXOP 
						
	| a_expr AND a_expr 
						
	| a_expr OR a_expr 
						
	| NOT a_expr 
						
	| a_expr LIKE a_expr 
						
	| a_expr LIKE a_expr ESCAPE a_expr 
						
	| a_expr NOT LIKE a_expr 
						
	| a_expr NOT LIKE a_expr ESCAPE a_expr 
						
	| a_expr ILIKE a_expr 
						
	| a_expr ILIKE a_expr ESCAPE a_expr 
						
	| a_expr NOT ILIKE a_expr 
						
	| a_expr NOT ILIKE a_expr ESCAPE a_expr 
						
	| a_expr SIMILAR TO a_expr %prec SIMILAR 
						
	| a_expr SIMILAR TO a_expr ESCAPE a_expr 
						
	| a_expr NOT SIMILAR TO a_expr %prec SIMILAR 
						
	| a_expr NOT SIMILAR TO a_expr ESCAPE a_expr 
						
	| a_expr IS NULL_P %prec IS 
						
	| a_expr ISNULL 
						
	| a_expr IS NOT NULL_P %prec IS 
						
	| a_expr NOTNULL 
						
	| row OVERLAPS row 
						
	| a_expr IS TRUE_P %prec IS 
						
	| a_expr IS NOT TRUE_P %prec IS 
						
	| a_expr IS FALSE_P %prec IS 
						
	| a_expr IS NOT FALSE_P %prec IS 
						
	| a_expr IS UNKNOWN %prec IS 
						
	| a_expr IS NOT UNKNOWN %prec IS 
						
	| a_expr IS DISTINCT FROM a_expr %prec IS 
						
	| a_expr IS NOT DISTINCT FROM a_expr %prec IS 
						
	| a_expr IS OF SQL_LP type_list SQL_RP %prec IS 
						
	| a_expr IS NOT OF SQL_LP type_list SQL_RP %prec IS 
						
	| a_expr BETWEEN opt_asymmetric b_expr AND b_expr %prec BETWEEN 
						
	| a_expr NOT BETWEEN opt_asymmetric b_expr AND b_expr %prec BETWEEN 
						
	| a_expr BETWEEN SYMMETRIC b_expr AND b_expr %prec BETWEEN 
						
	| a_expr NOT BETWEEN SYMMETRIC b_expr AND b_expr %prec BETWEEN 
						
	| a_expr IN_P in_expr 
						
	| a_expr NOT IN_P in_expr 
						
	| a_expr subquery_Op sub_type select_with_parens %prec Op 
						
	| a_expr subquery_Op sub_type SQL_LP expr_list SQL_RP %prec Op 
						
	| UNIQUE select_with_parens 
						
	| a_expr IS DOCUMENT_P %prec IS 
						
	| a_expr IS NOT DOCUMENT_P %prec IS 
	
	| a_expr SQL_LE a_expr 
						
	
	| a_expr SQL_GE a_expr 
						
	
	| a_expr SQL_NE a_expr 
						
	| SQL_LP a_expr SQL_RP SQL_LP Typename SQL_RP 
						
	| SQL_LP a_expr SQL_RP td_trans_date_time 
	
	| TD_GROUPING SQL_LP expr_list SQL_RP
	;

alter_generic_option_elem
	: generic_option_elem 
						
	| SET generic_option_elem 
						
	| ADD_P generic_option_elem 
						
	| DROP generic_option_name 
						
	;

with_clause
	: WITH cte_list 
						
	| WITH RECURSIVE cte_list 
						
	;

PreparableStmt
	: SelectStmt 
						
	| InsertStmt 
						
	| UpdateStmt 
						
	| DeleteStmt 
						
	;

def_elem
	: ColLabel SQL_EQ def_arg 
						
	| ColLabel 
						
	;

AlterOwnerStmt
	: ALTER AGGREGATE func_name aggr_args OWNER TO RoleId 
						
	| ALTER COLLATION any_name OWNER TO RoleId 
						
	| ALTER CONVERSION_P any_name OWNER TO RoleId 
						
	| ALTER DATABASE database_name OWNER TO RoleId 
						
	| ALTER DOMAIN_P any_name OWNER TO RoleId 
						
	| ALTER FUNCTION function_with_argtypes OWNER TO RoleId 
						
	| ALTER opt_procedural LANGUAGE name OWNER TO RoleId 
						
	| ALTER LARGE_P OBJECT_P NumericOnly OWNER TO RoleId 
						
	| ALTER OPERATOR any_operator oper_argtypes OWNER TO RoleId 
						
	| ALTER OPERATOR CLASS any_name USING access_method OWNER TO RoleId 
						
	| ALTER OPERATOR FAMILY any_name USING access_method OWNER TO RoleId 
						
	| ALTER SCHEMA name OWNER TO RoleId 
						
	| ALTER TYPE_P any_name OWNER TO RoleId 
						
	| ALTER TABLESPACE name OWNER TO RoleId 
						
	| ALTER TEXT_P SEARCH DICTIONARY any_name OWNER TO RoleId 
						
	| ALTER TEXT_P SEARCH CONFIGURATION any_name OWNER TO RoleId 
						
	| ALTER FOREIGN DATA_P WRAPPER name OWNER TO RoleId 
						
	| ALTER SERVER name OWNER TO RoleId 
						
	| ALTER EVENT TRIGGER name OWNER TO RoleId 
						
	;

CreateForeignServerStmt
	: CREATE SERVER name opt_type opt_foreign_server_version FOREIGN DATA_P WRAPPER name create_generic_options 
						
	;

database_name
	: ColId 
						
	;

CreateGroupStmt
	: CREATE GROUP_P RoleId opt_with OptRoleList 
						
	;

opt_restart_seqs
	: CONTINUE_P IDENTITY_P 
						
	| RESTART IDENTITY_P 
						
	| /* empty */ 
						
	;

opt_select_fetch_first_value
	: SignedIconst 
						
	| SQL_LP a_expr SQL_RP 
						
	| /* empty */ 
						
	;

row_or_rows
	: ROW 
						
	| ROWS 
						
	;

opt_array_bounds
	: opt_array_bounds SQL_LB SQL_RB 
						
	| opt_array_bounds SQL_LB Iconst SQL_RB 
						
	| /* empty */ 
						
	;

opt_indirection
	: /* empty */ 
						
	| opt_indirection indirection_el 
						
	;

AlterOpFamilyStmt
	: ALTER OPERATOR FAMILY any_name USING access_method ADD_P opclass_item_list 
						
	| ALTER OPERATOR FAMILY any_name USING access_method DROP opclass_drop_list 
						
	;

ConstraintAttr
	: DEFERRABLE 
						
	| NOT DEFERRABLE 
						
	| INITIALLY DEFERRED 
						
	| INITIALLY IMMEDIATE 
						
	;

columnElem
	: ColId 
						
	;

opt_index_name
	: index_name 
						
	| /* empty */ 
						
	;


func_return
	: func_type 
						
	;

create_generic_options
	: OPTIONS SQL_LP generic_option_list SQL_RP 
						
	| /* empty */ 
						
	;

SecLabelStmt
	: SECURITY LABEL opt_provider ON security_label_type any_name IS security_label 
						
	| SECURITY LABEL opt_provider ON AGGREGATE func_name aggr_args IS security_label 
						
	| SECURITY LABEL opt_provider ON FUNCTION func_name func_args IS security_label 
						
	| SECURITY LABEL opt_provider ON LARGE_P OBJECT_P NumericOnly IS security_label 
						
	| SECURITY LABEL opt_provider ON opt_procedural LANGUAGE any_name IS security_label 
						
	;

generic_option_name
	: ColLabel 
						
	;

xml_whitespace_option
	: PRESERVE WHITESPACE_P 
						
	| STRIP_P WHITESPACE_P 
						
	| /* empty */ 
						
	;

var_name
	: ColId 
						
	| var_name SQL_DOT ColId 
						
	;

privilege
	: SELECT opt_column_list 
						
	| REFERENCES opt_column_list 
						
	| CREATE opt_column_list 
						
	| ColId opt_column_list 
						
	;



table_ref
	: relation_expr opt_alias_clause sample_clause 
		// modify add sample_clause
						
	| func_table func_alias_clause 
						
	| LATERAL_P func_table func_alias_clause 
						
	| select_with_parens opt_alias_clause 
						
	| LATERAL_P select_with_parens opt_alias_clause 
						
	| joined_table 
						
	| SQL_LP joined_table SQL_RP alias_clause 
						
	;

extract_list
	: extract_arg FROM a_expr 
						
	| /* empty */ 
						
	;

old_aggr_list
	: old_aggr_elem 
						
	| old_aggr_list SQL_COMMA old_aggr_elem 
						
	;

CommentStmt
	: COMMENT ON comment_type any_name IS comment_text 
						
	| COMMENT ON AGGREGATE func_name aggr_args IS comment_text 
						
	| COMMENT ON FUNCTION func_name func_args IS comment_text 
						
	| COMMENT ON OPERATOR any_operator oper_argtypes IS comment_text 
						
	| COMMENT ON CONSTRAINT name ON any_name IS comment_text 
						
	| COMMENT ON RULE name ON any_name IS comment_text 
						
	| COMMENT ON RULE name IS comment_text 
						
	| COMMENT ON TRIGGER name ON any_name IS comment_text 
						
	| COMMENT ON OPERATOR CLASS any_name USING access_method IS comment_text 
						
	| COMMENT ON OPERATOR FAMILY any_name USING access_method IS comment_text 
						
	| COMMENT ON LARGE_P OBJECT_P NumericOnly IS comment_text 
						
	| COMMENT ON CAST SQL_LP Typename AS Typename SQL_RP IS comment_text 
						
	| COMMENT ON opt_procedural LANGUAGE any_name IS comment_text 
						
	| COMMENT ON TEXT_P SEARCH PARSER any_name IS comment_text 
						
	| COMMENT ON TEXT_P SEARCH DICTIONARY any_name IS comment_text 
						
	| COMMENT ON TEXT_P SEARCH TEMPLATE any_name IS comment_text 
						
	| COMMENT ON TEXT_P SEARCH CONFIGURATION any_name IS comment_text 
						
	;

grantee_list
	: grantee 
						
	| grantee_list SQL_COMMA grantee 
						
	;

ConstraintAttributeSpec
	: /* empty */ 
						
	| ConstraintAttributeSpec ConstraintAttributeElem 
						
	;

over_clause
	: OVER window_specification 
						
	| OVER ColId 
						
	| /* empty */ 
						
	;

frame_bound
	: UNBOUNDED PRECEDING 
						
	| UNBOUNDED FOLLOWING 
						
	| CURRENT_P ROW 
						
	| a_expr PRECEDING 
						
	| a_expr FOLLOWING 
						
	;

key_delete
	: ON DELETE_P key_action 
						
	;

key_action
	: NO ACTION 
						
	| RESTRICT 
						
	| CASCADE 
						
	| SET NULL_P 
						
	| SET DEFAULT 
						
	;

relation_expr_opt_alias_list 
	: relation_expr_opt_alias 
								
	| relation_expr_opt_alias_list SQL_COMMA relation_expr_opt_alias 
	;				

relation_expr_opt_alias
	: relation_expr %prec UMINUS 
						
	| relation_expr ColId 
						
	| relation_expr AS ColId 
						
	| relation_expr ALL 
		//todo3
						
	;

join_outer
	: OUTER_P 
						
	| /* empty */ 
						
	;

set_clause
	: single_set_clause 
						
	| multiple_set_clause 
						
	;

DropTrigStmt
	: DROP TRIGGER name ON any_name opt_drop_behavior 
						
	| DROP TRIGGER IF_P EXISTS name ON any_name opt_drop_behavior 
						
	;

AlterExtensionContentsStmt
	: ALTER EXTENSION name add_drop AGGREGATE func_name aggr_args 
						
	| ALTER EXTENSION name add_drop CAST SQL_LP Typename AS Typename SQL_RP 
						
	| ALTER EXTENSION name add_drop COLLATION any_name 
						
	| ALTER EXTENSION name add_drop CONVERSION_P any_name 
						
	| ALTER EXTENSION name add_drop DOMAIN_P any_name 
						
	| ALTER EXTENSION name add_drop FUNCTION function_with_argtypes 
						
	| ALTER EXTENSION name add_drop opt_procedural LANGUAGE name 
						
	| ALTER EXTENSION name add_drop OPERATOR any_operator oper_argtypes 
						
	| ALTER EXTENSION name add_drop OPERATOR CLASS any_name USING access_method 
						
	| ALTER EXTENSION name add_drop OPERATOR FAMILY any_name USING access_method 
						
	| ALTER EXTENSION name add_drop SCHEMA name 
						
	| ALTER EXTENSION name add_drop EVENT TRIGGER name 
						
	| ALTER EXTENSION name add_drop TABLE any_name 
						
	| ALTER EXTENSION name add_drop TEXT_P SEARCH PARSER any_name 
						
	| ALTER EXTENSION name add_drop TEXT_P SEARCH DICTIONARY any_name 
						
	| ALTER EXTENSION name add_drop TEXT_P SEARCH TEMPLATE any_name 
						
	| ALTER EXTENSION name add_drop TEXT_P SEARCH CONFIGURATION any_name 
						
	| ALTER EXTENSION name add_drop SEQUENCE any_name 
						
	| ALTER EXTENSION name add_drop VIEW any_name 
						
	| ALTER EXTENSION name add_drop FOREIGN TABLE any_name 
						
	| ALTER EXTENSION name add_drop FOREIGN DATA_P WRAPPER name 
						
	| ALTER EXTENSION name add_drop SERVER name 
						
	| ALTER EXTENSION name add_drop TYPE_P any_name 
						
	;

ConstDatetime
	: TIMESTAMP SQL_LP Iconst SQL_RP opt_timezone 
						
	| TIMESTAMP opt_timezone 
						
	| TIME SQL_LP Iconst SQL_RP opt_timezone 
						
	| TIME opt_timezone 
						
	| TD_DATE format_clause 
								
	| TD_DATE 
						
	| DATETIME 

	| TIMESTAMP SQL_LP Iconst SQL_RP format_clause opt_timezone

	| TIMESTAMP format_clause opt_timezone

	| TIME SQL_LP Iconst SQL_RP format_clause opt_timezone 

	| TIME format_clause opt_timezone 

	| DATETIME format_clause 

	;

format_clause
	: FORMAT Sconst 
								
	| SQL_LP format_clause SQL_RP 
	;				

opclass_item
	: OPERATOR Iconst any_operator opclass_purpose opt_recheck 
						
	| OPERATOR Iconst any_operator oper_argtypes opclass_purpose opt_recheck 
						
	| FUNCTION Iconst func_name func_args 
						
	| FUNCTION Iconst SQL_LP type_list SQL_RP func_name func_args 
						
	| STORAGE Typename 
						
	;

reloption_list
	: reloption_elem 
						
	| reloption_list SQL_COMMA reloption_elem 
						
	;

opt_transaction
	: WORK 
						
	| TRANSACTION 
						
	| /* empty */ 
						
	;

xml_root_version
	: VERSION_P a_expr 
						
	| VERSION_P NO VALUE_P 
						
	;

extract_arg
	: IDENT 
						
	| YEAR_P 
						
	| MONTH_P 
						
	| DAY_P 
						
	| HOUR_P 
						
	| MINUTE_P 
						
	| SECOND_P 
						
	| Sconst 
						
	;

any_operator
	: all_Op 
						
	| ColId SQL_DOT any_operator 
						
	;

sortby
	: a_expr USING qual_all_Op opt_nulls_order 
						
	| a_expr opt_asc_desc opt_nulls_order 
						
	;

opt_enum_val_list
	: enum_val_list 
						
	| /* empty */ 
						
	;

trim_list
	: a_expr FROM expr_list 
						
	| FROM expr_list 
						
	| expr_list 
						
	;

substr_for
	: FOR a_expr 
						
	;

opt_sort_clause
	: sort_clause 
						
	| /* empty */ 
						
	;

limit_clause
	: LIMIT select_limit_value 
						
	| LIMIT select_limit_value SQL_COMMA select_offset_value 
						
	| FETCH first_or_next opt_select_fetch_first_value row_or_rows ONLY 
						
	;

CharacterWithoutLength
	: character opt_charset 
						
	;

vacuum_option_elem
	: analyze_keyword 
						
	| VERBOSE 
						
	| FREEZE 
						
	| FULL 
						
	;

stmtmulti
	: stmtmulti SQL_SEMI stmt 
						
	| stmt 
						
	;

alter_table_cmd
	: ADD_P columnDef 
						
	| ADD_P COLUMN columnDef 
						
	| ALTER opt_column ColId alter_column_default 
						
	| ALTER opt_column ColId DROP NOT NULL_P 
						
	| ALTER opt_column ColId SET NOT NULL_P 
						
	| ALTER opt_column ColId SET STATISTICS SignedIconst 
						
	| ALTER opt_column ColId SET reloptions 
						
	| ALTER opt_column ColId RESET reloptions 
						
	| ALTER opt_column ColId SET STORAGE ColId 
						
	| DROP opt_column IF_P EXISTS ColId opt_drop_behavior 
						
	| DROP opt_column ColId opt_drop_behavior 
						
	| ALTER opt_column ColId opt_set_data TYPE_P Typename opt_collate_clause alter_using 
						
	| ALTER opt_column ColId alter_generic_options 
						
	| ADD_P TableConstraint 
						
	| VALIDATE CONSTRAINT name 
						
	| DROP CONSTRAINT IF_P EXISTS name opt_drop_behavior 
						
	| DROP CONSTRAINT name opt_drop_behavior 
						
	| SET WITH OIDS 
						
	| SET WITHOUT OIDS 
						
	| CLUSTER ON name 
						
	| SET WITHOUT CLUSTER 
						
	| ENABLE_P TRIGGER name 
						
	| ENABLE_P ALWAYS TRIGGER name 
						
	| ENABLE_P REPLICA TRIGGER name 
						
	| ENABLE_P TRIGGER ALL 
						
	| ENABLE_P TRIGGER USER 
						
	| DISABLE_P TRIGGER name 
						
	| DISABLE_P TRIGGER ALL 
						
	| DISABLE_P TRIGGER USER 
						
	| ENABLE_P RULE name 
						
	| ENABLE_P ALWAYS RULE name 
						
	| ENABLE_P REPLICA RULE name 
						
	| DISABLE_P RULE name 
						
	| INHERIT qualified_name 
						
	| NO INHERIT qualified_name 
						
	| OF any_name 
						
	| NOT OF 
						
	| OWNER TO RoleId 
						
	| SET TABLESPACE name 
						
	| SET reloptions 
						
	| RESET reloptions 
						
	| alter_generic_options 
						
	;

in_expr
	: select_with_parens 
						
	| SQL_LP expr_list SQL_RP 
						
	| ICONST 
						
	;

index_name
	: ColId 
						
	;

AlterUserSetStmt
	: ALTER USER RoleId SetResetClause 
						
	;

opt_type
	: TYPE_P Sconst 
						
	| /* empty */ 
						
	;

OptTypedTableElementList
	: SQL_LP TypedTableElementList SQL_RP 
						
	| /* empty */ 
						
	;

CreateAsStmt
	: CREATE OptTemp TABLE create_as_target AS SelectStmt opt_with_data 
						
	| CREATE OptSetMultiset OptTemp TABLE qualified_name AS SelectStmt opt_with_data 
						
	;

OptSetMultiset
	: MULTISET 
			
	| SET 

	;

DropUserMappingStmt
	: DROP USER MAPPING FOR auth_ident SERVER name 
						
	| DROP USER MAPPING IF_P EXISTS FOR auth_ident SERVER name 
						
	;

reserved_keyword
	: ALL 
						
	| ANALYSE 
						
	| ANALYZE 
						
	| AND 
						
	| ANY 
						
	| ARRAY 
						
	| AS 
						
	| ASC 
						
	| ASYMMETRIC 
						
	| BOTH 
						
	| CASE 
						
	| CAST 
						
	| CHECK 
						
	| COLLATE 
						
	| COLUMN 
						
	| CONSTRAINT 
						
	| CREATE 
						
	| CURRENT_CATALOG 
						
	| CURRENT_DATE 
						
	| CURRENT_ROLE 
						
	| CURRENT_TIME 
						
	| CURRENT_TIMESTAMP 
						
	| CURRENT_USER 
						
	| DEFAULT 
						
	| DEFERRABLE 
						
	| DESC 
						
	| DISTINCT 
						
	| DO 
						
	| ELSE 
						
	| END_P 
						
	| EXCEPT 
						
	| FALSE_P 
						
	| FETCH 
						
	| FOR 
						
	| FOREIGN 
						
	| FROM 
						
	| GRANT 
						
	| GROUP_P 
						
	| HAVING 
						
	| IN_P 
						
	| INITIALLY 
						
	| INTERSECT 
						
	| INTO 
						
	| LATERAL_P 
						
	| LEADING 
						
	| LIMIT 
						
	| LOCALTIME 
						
	| LOCALTIMESTAMP 
						
	| NOT 
						
	| NULL_P 
						
	| OFFSET 
						
	| ON 
						
	| ONLY 
						
	| OR 
						
	| ORDER 
						
	| PLACING 
						
	| PRIMARY 
						
	| REFERENCES 
						
	| RETURNING 
						
	| SELECT 
						
	| SESSION_USER 
						
	| SOME 
						
	| SYMMETRIC 
						
	| TABLE 
						
	| THEN 
						
	| TO 
						
	| TRAILING 
						
	| TRUE_P 
						
	| UNION 
						
	| UNIQUE 
						
	| USER 
						
	| USING 
						
	| VARIADIC 
						
	| WHEN 
						
	| WHERE 
						
	| WINDOW 
						
	| WITH 
						
	;

set_rest
	: TRANSACTION transaction_mode_list 
						
	| SESSION CHARACTERISTICS AS TRANSACTION transaction_mode_list 
						
	| set_rest_more 
						
	;

LoadStmt
	: LOAD file_name 
						
	;

explain_option_arg
	: opt_boolean_or_string 
						
	| NumericOnly 
						
	| /* empty */ 
						
	;

DropGroupStmt
	: DROP GROUP_P name_list 
						
	| DROP GROUP_P IF_P EXISTS name_list 
						
	;

opt_check_option
	: WITH CHECK OPTION 
						
	| WITH CASCADED CHECK OPTION 
						
	| WITH LOCAL CHECK OPTION 
						
	| /* empty */ 
						
	;

TriggerEvents
	: TriggerOneEvent 
						
	| TriggerEvents OR TriggerOneEvent 
						
	;

grantee
	: RoleId 
						
	| GROUP_P RoleId 
						
	;

any_name
	: ColId 
						
	| ColId attrs 
						
	;

TriggerForSpec
	: FOR TriggerForOptEach TriggerForType 
						
	| /* empty */ 
						
	;

MathOp
	: SQL_PLUS 
						
	| SQL_MINUS 
						
	| SQL_MUL 
						
	| SQL_DIV 
						
	| SQL_MOD 
						
	| SQL_POWER 
						
	| SQL_LT 
						
	| SQL_GT 
						
	| SQL_EQ 
						
	;

OptTableElementList
	: TableElementList 
						
	| /* empty */ 
						
	;

ColConstraint
	: CONSTRAINT name ColConstraintElem 
						
	| ColConstraintElem 
						
	| ConstraintAttr 
						
	| COLLATE any_name 
						
	;

TriggerWhen
	: WHEN SQL_LP a_expr SQL_RP 
						
	| /* empty */ 
						
	;

ExplainStmt
	: EXPLAIN ExplainableStmt 
						
	| EXPLAIN analyze_keyword opt_verbose ExplainableStmt 
						
	| EXPLAIN VERBOSE ExplainableStmt 
						
	| EXPLAIN SQL_LP explain_option_list SQL_RP ExplainableStmt 
						
	;

opt_verbose
	: VERBOSE 
						
	| /* empty */ 
						
	;

vacuum_option_list
	: vacuum_option_elem 
						
	| vacuum_option_list SQL_COMMA vacuum_option_elem 
						
	;

defacl_privilege_target
	: TABLES 
						
	| FUNCTIONS 
						
	| SEQUENCES 
						
	| TYPES_P 
						
	;

AlterTableStmt
	: ALTER TABLE relation_expr alter_table_cmds 
						
	| ALTER TABLE IF_P EXISTS relation_expr alter_table_cmds 
						
	| ALTER INDEX qualified_name alter_table_cmds 
						
	| ALTER INDEX IF_P EXISTS qualified_name alter_table_cmds 
						
	| ALTER SEQUENCE qualified_name alter_table_cmds 
						
	| ALTER SEQUENCE IF_P EXISTS qualified_name alter_table_cmds 
						
	| ALTER VIEW qualified_name alter_table_cmds 
						
	| ALTER VIEW IF_P EXISTS qualified_name alter_table_cmds 
						
	;

opt_encoding
	: Sconst 
						
	| DEFAULT 
						
	| /* empty */ 
						
	;

CreateExtensionStmt
	: CREATE EXTENSION name opt_with create_extension_opt_list 
						
	| CREATE EXTENSION IF_P NOT EXISTS name opt_with create_extension_opt_list 
						
	;

type_list
	: Typename 
						
	| type_list SQL_COMMA Typename 
						
	;

handler_name
	: name 
						
	| name attrs 
						
	;

CreateForeignTableStmt
	: CREATE FOREIGN TABLE qualified_name OptForeignTableElementList SERVER name create_generic_options 
						
	| CREATE FOREIGN TABLE IF_P NOT EXISTS qualified_name OptForeignTableElementList SERVER name create_generic_options 
						
	;

opt_nowait
	: NOWAIT 
						
	| /* empty */ 
						
	;

common_table_expr
	: name opt_name_list AS SQL_LP PreparableStmt SQL_RP 

	;

opt_using
	: USING 
						
	| /* empty */ 
						
	;

OptSchemaName
	: ColId 
						
	| /* empty */ 
						
	;

opt_drop_behavior
	: CASCADE 
						
	| RESTRICT 
						
	| /* empty */ 
						
	;

xml_attribute_el
	: a_expr AS ColLabel 
						
	| a_expr 
						
	;

copy_from
	: FROM 
						
	| TO 
						
	;

DefineStmt
	: CREATE AGGREGATE func_name aggr_args definition 
						
	| CREATE AGGREGATE func_name old_aggr_definition 
						
	| CREATE OPERATOR any_operator definition 
						
	| CREATE TYPE_P any_name definition 
						
	| CREATE TYPE_P any_name 
						
	| CREATE TYPE_P any_name AS SQL_LP OptTableFuncElementList SQL_RP 
						
	| CREATE TYPE_P any_name AS ENUM_P SQL_LP opt_enum_val_list SQL_RP 
						
	| CREATE TYPE_P any_name AS RANGE definition 
						
	| CREATE TEXT_P SEARCH PARSER any_name definition 
						
	| CREATE TEXT_P SEARCH DICTIONARY any_name definition 
						
	| CREATE TEXT_P SEARCH TEMPLATE any_name definition 
						
	| CREATE TEXT_P SEARCH CONFIGURATION any_name definition 
						
	| CREATE COLLATION any_name definition 
						
	| CREATE COLLATION any_name FROM any_name 
						
	;

CreatedbStmt
	: CREATE DATABASE database_name opt_with createdb_opt_list 
						
	;

set_rest_more
	: var_name TO var_list 
						
	| var_name SQL_EQ var_list 
						
	| var_name TO DEFAULT 
						
	| var_name SQL_EQ DEFAULT 
						
	| var_name FROM CURRENT_P 
						
	| TIME ZONE zone_value 
						
	| CATALOG_P Sconst 
						
	| SCHEMA Sconst 
						
	| NAMES opt_encoding 
						
	| ROLE ColId_or_Sconst 
						
	| SESSION AUTHORIZATION ColId_or_Sconst 
						
	| SESSION AUTHORIZATION DEFAULT 
						
	| XML_P OPTION document_or_content 
						
	| TRANSACTION SNAPSHOT Sconst 
						
	;

SignedIconst
	: Iconst 
						
	| SQL_PLUS Iconst 
						
	| SQL_MINUS Iconst 
						
	;

OptWith
	: WITH reloptions 
						
	| WITH OIDS 
						
	| WITHOUT OIDS 
						
	| /* empty */ 
						
	;

alter_type_cmds
	: alter_type_cmd 
						
	| alter_type_cmds SQL_COMMA alter_type_cmd 
						
	;

insert_column_list
	: insert_column_item 
						
	| insert_column_list SQL_COMMA insert_column_item 
						
	;

schema_stmt
	: CreateStmt 
						
	| IndexStmt 
						
	| CreateSeqStmt 
						
	| CreateTrigStmt 
						
	| GrantStmt 
						
	| ViewStmt 
						
	;

frame_extent
	: frame_bound 
						
	| BETWEEN frame_bound AND frame_bound 
						
	;

AnalyzeStmt
	: analyze_keyword opt_verbose 
						
	| analyze_keyword opt_verbose qualified_name opt_name_list 
						
	;

GrantStmt
	: GRANT privileges ON privilege_target TO grantee_list opt_grant_grant_option 
						
	;

table_func_column_list
	: table_func_column 
						
	| table_func_column_list SQL_COMMA table_func_column 
						
	;

opt_reloptions
	: WITH reloptions 
						
	| /* empty */ 
						
	;

character
	: CHARACTER opt_varying 
						
	| CHAR_P opt_varying 
						
	| VARCHAR 
						
	| NATIONAL CHARACTER opt_varying 
						
	| NATIONAL CHAR_P opt_varying 
						
	| NCHAR opt_varying 
						
	| TD_LONG VARCHAR 
								
	;

CreateAssertStmt
	: CREATE ASSERTION name CHECK SQL_LP a_expr SQL_RP ConstraintAttributeSpec 
						
	;

OptTempTableName
	: TEMPORARY opt_table qualified_name 
						
	| TEMP opt_table qualified_name 
						
	| LOCAL TEMPORARY opt_table qualified_name 
						
	| LOCAL TEMP opt_table qualified_name 
						
	| GLOBAL TEMPORARY opt_table qualified_name 
						
	| GLOBAL TEMP opt_table qualified_name 
						
	| UNLOGGED opt_table qualified_name 
						
	| TABLE qualified_name 
						
	| qualified_name 
						
	;

opt_freeze
	: FREEZE 
						
	| /* empty */ 
						
	;

func_args_with_defaults_list
	: func_arg_with_default 
						
	| func_args_with_defaults_list SQL_COMMA func_arg_with_default 
						
	;

OptConsTableSpace
	: USING INDEX TABLESPACE name 
						
	| /* empty */ 
						
	;

AlterTSConfigurationStmt
	: ALTER TEXT_P SEARCH CONFIGURATION any_name ADD_P MAPPING FOR name_list WITH any_name_list 
						
	| ALTER TEXT_P SEARCH CONFIGURATION any_name ALTER MAPPING FOR name_list WITH any_name_list 
						
	| ALTER TEXT_P SEARCH CONFIGURATION any_name ALTER MAPPING REPLACE any_name WITH any_name 
						
	| ALTER TEXT_P SEARCH CONFIGURATION any_name ALTER MAPPING FOR name_list REPLACE any_name WITH any_name 
						
	| ALTER TEXT_P SEARCH CONFIGURATION any_name DROP MAPPING FOR name_list 
						
	| ALTER TEXT_P SEARCH CONFIGURATION any_name DROP MAPPING IF_P EXISTS FOR name_list 
						
	;

RemoveFuncStmt
	: DROP FUNCTION func_name func_args opt_drop_behavior 
						
	| DROP FUNCTION IF_P EXISTS func_name func_args opt_drop_behavior 
						
	;

explain_option_name
	: ColId 
						
	| analyze_keyword 
						
	| VERBOSE 
						
	;

createdb_opt_item
	: TABLESPACE opt_equal name 
						
	| TABLESPACE opt_equal DEFAULT 
						
	| LOCATION opt_equal Sconst 
						
	| LOCATION opt_equal DEFAULT 
						
	| TEMPLATE opt_equal name 
						
	| TEMPLATE opt_equal DEFAULT 
						
	| ENCODING opt_equal Sconst 
						
	| ENCODING opt_equal Iconst 
						
	| ENCODING opt_equal DEFAULT 
						
	| LC_COLLATE_P opt_equal Sconst 
						
	| LC_COLLATE_P opt_equal DEFAULT 
						
	| LC_CTYPE_P opt_equal Sconst 
						
	| LC_CTYPE_P opt_equal DEFAULT 
						
	| CONNECTION LIMIT opt_equal SignedIconst 
						
	| OWNER opt_equal name 
						
	| OWNER opt_equal DEFAULT 
						
	;

window_definition
	: ColId AS window_specification 
						
	;

opclass_item_list
	: opclass_item 
						
	| opclass_item_list SQL_COMMA opclass_item 
						
	;

NumericOnly
	: FCONST 
						
	| SQL_MINUS FCONST 
						
	| SignedIconst 
						
	;

array_expr_list
	: array_expr 
						
	| array_expr_list SQL_COMMA array_expr 
						
	;

opt_by
	: BY 
						
	| /* empty */ 
						
	;

param_name
	: type_function_name 
						
	;

joined_table
	: SQL_LP joined_table SQL_RP 
						
	| table_ref CROSS JOIN table_ref 
						
	| table_ref join_type JOIN table_ref join_qual 
						
	| table_ref JOIN table_ref join_qual 
						
	| table_ref NATURAL join_type JOIN table_ref 
						
	| table_ref NATURAL JOIN table_ref 
						
	;

TableLikeOption
	: DEFAULTS 
						
	| CONSTRAINTS 
						
	| INDEXES 
						
	| STORAGE 
						
	| COMMENTS 
						
	| ALL 
						
	;

create_extension_opt_item
	: SCHEMA name 
						
	| VERSION_P ColId_or_Sconst 
						
	| FROM ColId_or_Sconst 
						
	;

fetch_args
	: cursor_name 
						
	| from_in cursor_name 
						
	| NEXT opt_from_in cursor_name 
						
	| PRIOR opt_from_in cursor_name 
						
	| FIRST_P opt_from_in cursor_name 
						
	| LAST_P opt_from_in cursor_name 
						
	| ABSOLUTE_P SignedIconst opt_from_in cursor_name 
						
	| RELATIVE_P SignedIconst opt_from_in cursor_name 
						
	| SignedIconst opt_from_in cursor_name 
						
	| ALL opt_from_in cursor_name 
						
	| FORWARD opt_from_in cursor_name 
						
	| FORWARD SignedIconst opt_from_in cursor_name 
						
	| FORWARD ALL opt_from_in cursor_name 
						
	| BACKWARD opt_from_in cursor_name 
						
	| BACKWARD SignedIconst opt_from_in cursor_name 
						
	| BACKWARD ALL opt_from_in cursor_name 
						
	;

select_no_parens
	: simple_select 
						
	| select_clause sort_clause 
						
	| select_clause opt_sort_clause for_locking_clause opt_select_limit 
						
	| select_clause opt_sort_clause select_limit opt_for_locking_clause 
						
	| with_clause select_clause 
						
	| with_clause select_clause sort_clause 
						
	| with_clause select_clause opt_sort_clause for_locking_clause opt_select_limit 
						
	| with_clause select_clause opt_sort_clause select_limit opt_for_locking_clause 
						
	;

locked_rels_list
	: OF qualified_name_list 
						
	| /* empty */ 
						
	;

foreign_server_version
	: VERSION_P Sconst 
						
	| VERSION_P NULL_P 
						
	;

UpdateStmt
	: opt_with_clause UPDATE relation_expr_opt_alias from_clause SET set_clause_list where_or_current_clause returning_clause 
						
	;

opt_boolean_or_string
	: TRUE_P 
						
	| FALSE_P 
						
	| ON 
						
	| ColId_or_Sconst 
						
	;

TriggerFuncArg
	: Iconst 
						
	| FCONST 
						
	| Sconst 
						
	| ColLabel 
						
	;

opt_unique
	: UNIQUE 
						
	| /* empty */ 
						
	;

simple_select
	: SELECT opt_distinct target_list into_clause from_clause where_clause group_clause having_clause window_clause 
						
	| values_clause 
						
	| TABLE relation_expr 
						
	| select_clause UNION opt_all select_clause 
						
	| select_clause INTERSECT opt_all select_clause 
						
	| select_clause EXCEPT opt_all select_clause 
						
	;

window_definition_list
	: window_definition 
						
	| window_definition_list SQL_COMMA window_definition 
						
	;

transaction_mode_list
	: transaction_mode_item 
						
	| transaction_mode_list SQL_COMMA transaction_mode_item 
						
	| transaction_mode_list transaction_mode_item 
						
	;

ConstraintElem
	: CHECK SQL_LP a_expr SQL_RP ConstraintAttributeSpec 
						
	| UNIQUE SQL_LP columnList SQL_RP opt_definition OptConsTableSpace ConstraintAttributeSpec 
						
	| UNIQUE ExistingIndex ConstraintAttributeSpec 
						
	| PRIMARY KEY SQL_LP columnList SQL_RP opt_definition OptConsTableSpace ConstraintAttributeSpec 
						
	| PRIMARY KEY ExistingIndex ConstraintAttributeSpec 
						
	| EXCLUDE access_method_clause SQL_LP ExclusionConstraintList SQL_RP opt_definition OptConsTableSpace ExclusionWhereClause ConstraintAttributeSpec 
						
	| FOREIGN KEY SQL_LP columnList SQL_RP REFERENCES qualified_name opt_column_list key_match key_actions ConstraintAttributeSpec 
						
	;

CreateUserStmt
	: CREATE USER RoleId opt_with OptRoleList 
						
	;

TriggerFuncArgs
	: TriggerFuncArg 
						
	| TriggerFuncArgs SQL_COMMA TriggerFuncArg 
						
	| /* empty */ 
						
	;

reloption_elem
	: ColLabel SQL_EQ def_arg 
						
	| ColLabel 
						
	| ColLabel SQL_DOT ColLabel SQL_EQ def_arg 
						
	| ColLabel SQL_DOT ColLabel 
						
	;

case_arg
	: a_expr 
						
	| /* empty */ 
						
	;

b_expr
	: c_expr 
						
	| b_expr SQL_TYPECAST Typename 
						
	| SQL_PLUS b_expr %prec UMINUS 
						
	| SQL_MINUS b_expr %prec UMINUS 
						
	| b_expr SQL_PLUS b_expr 
						
	| b_expr SQL_MINUS b_expr 
						
	| b_expr SQL_MUL b_expr 
						
	| b_expr SQL_DIV b_expr 
						
	| b_expr SQL_MOD b_expr 
						
	| b_expr SQL_POWER b_expr 
						
	| b_expr SQL_LT b_expr 
						
	| b_expr SQL_GT b_expr 
						
	| b_expr SQL_EQ b_expr 
						
	| b_expr qual_Op b_expr %prec Op 
						
	| qual_Op b_expr %prec Op 
						
	| b_expr qual_Op %prec POSTFIXOP 
						
	| b_expr IS DISTINCT FROM b_expr %prec IS 
						
	| b_expr IS NOT DISTINCT FROM b_expr %prec IS 
						
	| b_expr IS OF SQL_LP type_list SQL_RP %prec IS 
						
	| b_expr IS NOT OF SQL_LP type_list SQL_RP %prec IS 
						
	| b_expr IS DOCUMENT_P %prec IS 
						
	| b_expr IS NOT DOCUMENT_P %prec IS 
						
	| b_expr SQL_GE b_expr 
						
	| b_expr SQL_LE b_expr 
						
	| b_expr SQL_NE b_expr 
						
	;

set_target
	: ColId opt_indirection 
						
	;

VacuumStmt
	: VACUUM opt_full opt_freeze opt_verbose 
						
	| VACUUM opt_full opt_freeze opt_verbose qualified_name 
						
	| VACUUM opt_full opt_freeze opt_verbose AnalyzeStmt 
						
	| VACUUM SQL_LP vacuum_option_list SQL_RP 
						
	| VACUUM SQL_LP vacuum_option_list SQL_RP qualified_name opt_name_list 
						
	;

AlterGroupStmt
	: ALTER GROUP_P RoleId add_drop USER name_list 
						
	;

prep_type_clause
	: SQL_LP type_list SQL_RP 
						
	| /* empty */ 
						
	;

analyze_keyword
	: ANALYZE 
						
	| ANALYSE 
						
	;

OptRoleList
	: OptRoleList CreateOptRoleElem 
						
	| /* empty */ 
						
	;

comment_text
	: Sconst 
						
	| NULL_P 
						
	;

AlterOptRoleElem
	: PASSWORD Sconst 
						
	| PASSWORD NULL_P 
						
	| ENCRYPTED PASSWORD Sconst 
						
	| UNENCRYPTED PASSWORD Sconst 
						
	| INHERIT 
						
	| CONNECTION LIMIT SignedIconst 
						
	| VALID UNTIL Sconst 
						
	| USER name_list 
						
	| IDENT 
						
	;

Sconst
	: SCONST 
						
	;

opclass_drop_list
	: opclass_drop 
						
	| opclass_drop_list SQL_COMMA opclass_drop 
						
	;

DropPLangStmt
	: DROP opt_procedural LANGUAGE ColId_or_Sconst opt_drop_behavior 
						
	| DROP opt_procedural LANGUAGE IF_P EXISTS ColId_or_Sconst opt_drop_behavior 
						
	;

copy_generic_opt_elem
	: ColLabel copy_generic_opt_arg 
						
	;

DoStmt
	: DO dostmt_opt_list 
						
	;

create_extension_opt_list
	: create_extension_opt_list create_extension_opt_item 
						
	| /* empty */ 
						
	;

ColLabel
	: IDENT 
						
	| unreserved_keyword 
						
	| col_name_keyword 
						
	| type_func_name_keyword 
						
	| reserved_keyword 
						
	;

DropStmt
	: DROP drop_type IF_P EXISTS any_name_list opt_drop_behavior 
						
	| DROP drop_type any_name_list opt_drop_behavior 
						
	| DROP INDEX CONCURRENTLY any_name_list opt_drop_behavior 
						
	| DROP INDEX CONCURRENTLY IF_P EXISTS any_name_list opt_drop_behavior 
						
	;

generic_option_list
	: generic_option_elem 
						
	| generic_option_list SQL_COMMA generic_option_elem 
						
	;

OptTableSpace
	: TABLESPACE name 
						
	| /* empty */ 
						
	;

GrantRoleStmt
	: GRANT privilege_list TO name_list opt_grant_admin_option opt_granted_by 
						
	;

DropFdwStmt
	: DROP FOREIGN DATA_P WRAPPER name opt_drop_behavior 
						
	| DROP FOREIGN DATA_P WRAPPER IF_P EXISTS name opt_drop_behavior 
						
	;

IndexStmt
	: CREATE opt_unique INDEX opt_concurrently opt_index_name ON qualified_name access_method_clause SQL_LP index_params SQL_RP opt_reloptions OptTableSpace where_clause 
						
	;

for_locking_clause
	: for_locking_items 
						
	| FOR READ ONLY 
						
	;

comment_type
	: COLUMN 
						
	| DATABASE 
						
	| SCHEMA 
						
	| INDEX 
						
	| SEQUENCE 
						
	| TABLE 
						
	| DOMAIN_P 
						
	| TYPE_P 
						
	| VIEW 
						
	| COLLATION 
						
	| CONVERSION_P 
						
	| TABLESPACE 
						
	| EXTENSION 
						
	| ROLE 
						
	| FOREIGN TABLE 
						
	| SERVER 
						
	| FOREIGN DATA_P WRAPPER 
						
	| EVENT TRIGGER 
						
	;

func_arg_list
	: func_arg_expr 
						
	| func_arg_list SQL_COMMA func_arg_expr 
						
	;

iso_level
	: READ UNCOMMITTED 
						
	| READ COMMITTED 
						
	| REPEATABLE READ 
						
	| SERIALIZABLE 
						
	;

ctext_row
	: SQL_LP ctext_expr_list SQL_RP 
						
	;

event_trigger_when_list
	: event_trigger_when_item 
						
	| event_trigger_when_list AND event_trigger_when_item 
						
	;

interval_day
	: DAY_P 
						
	| DAY_P SQL_LP Iconst SQL_RP 
						
	;

interval_hour
	: HOUR_P 
						
	| HOUR_P SQL_LP Iconst SQL_RP 
						
	;

td_trans_date_time 
	: YEAR_P TO MONTH_P 
						
	| interval_day TO HOUR_P 
						
	| interval_day TO MINUTE_P 
						
	| interval_day TO interval_second 
						
	| interval_hour TO MINUTE_P 
						
	| interval_hour TO interval_second 
						
	| MINUTE_P TO interval_second 
						
	;

opt_interval
	: YEAR_P 
						
	| MONTH_P 
						
	| DAY_P 
						
	| HOUR_P 
						
	| MINUTE_P 
						
	| interval_second 
						
	| YEAR_P TO MONTH_P 
						
	| DAY_P TO HOUR_P 
						
	| DAY_P TO MINUTE_P 
						
	| DAY_P TO interval_second 
						
	| HOUR_P TO MINUTE_P 
						
	| HOUR_P TO interval_second 
						
	| MINUTE_P TO interval_second 
						
	|  /* empty */
						
	;

target_list
	: target_el 
						
	| target_list SQL_COMMA target_el 
						
	;

security_label
	: Sconst 
						
	| NULL_P 
						
	;

VariableResetStmt
	: RESET var_name 
						
	| RESET TIME ZONE 
						
	| RESET TRANSACTION ISOLATION LEVEL 
						
	| RESET SESSION AUTHORIZATION 
						
	| RESET ALL 
						
	;

ConstInterval
	: INTERVAL 
						
	;

ReindexStmt
	: REINDEX reindex_type qualified_name opt_force 
						
	| REINDEX SYSTEM_P name opt_force 
						
	| REINDEX DATABASE name opt_force 
						
	;

GenericType
	: type_function_name opt_type_modifiers 
						
	| type_function_name attrs opt_type_modifiers 
						
	;

opt_opfamily
	: FAMILY any_name 
						
	| /* empty */ 
						
	;

FunctionSetResetClause
	: SET set_rest_more 
						
	| VariableResetStmt 
						
	;

ClosePortalStmt
	: CLOSE cursor_name 
						
	| CLOSE ALL 
						
	;

AlterUserStmt
	: ALTER USER RoleId opt_with AlterOptRoleList 
						
	;

ExecuteStmt
	: EXECUTE name execute_param_clause 
						
	| CREATE OptTemp TABLE create_as_target AS EXECUTE name execute_param_clause opt_with_data 
						
	;

execute_param_clause
	: SQL_LP expr_list SQL_RP 
						
	| /* empty */ 
						
	;

copy_generic_opt_arg
	: opt_boolean_or_string 
						
	| NumericOnly 
						
	| SQL_MUL 
						
	| SQL_LP copy_generic_opt_arg_list SQL_RP 
						
	| /* empty */ 
						
	;

AlterExtensionStmt
	: ALTER EXTENSION name UPDATE alter_extension_opt_list 
						
	;

alter_type_cmd
	: ADD_P ATTRIBUTE TableFuncElement opt_drop_behavior 
						
	| DROP ATTRIBUTE IF_P EXISTS ColId opt_drop_behavior 
						
	| DROP ATTRIBUTE ColId opt_drop_behavior 
						
	| ALTER ATTRIBUTE ColId opt_set_data TYPE_P Typename opt_collate_clause opt_drop_behavior 
						
	;

opt_equal
	: SQL_EQ 
						
	| /* empty */ 
						
	;

opt_collate
	: COLLATE any_name 
						
	| /* empty */ 
						
	;

insert_column_item
	: ColId opt_indirection 
						
	;

dostmt_opt_list
	: dostmt_opt_item 
						
	| dostmt_opt_list dostmt_opt_item 
						
	;

ConstraintAttributeElem
	: NOT DEFERRABLE 
						
	| DEFERRABLE 
						
	| INITIALLY IMMEDIATE 
						
	| INITIALLY DEFERRED 
						
	| NOT VALID 
						
	| NO INHERIT 
						
	;

relation_expr_list
	: relation_expr 
						
	| relation_expr_list SQL_COMMA relation_expr 
						
	;

RuleActionStmtOrEmpty
	: RuleActionStmt 
						
	| /* empty */ 
						
	;

qual_Op
	: Op 
						
	| OPERATOR SQL_LP any_operator SQL_RP 
						
	;

relation_expr
	: qualified_name 
						
	| qualified_name SQL_MUL 
						
	| ONLY qualified_name 
						
	| ONLY SQL_LP qualified_name SQL_RP 
						
	;

alterdb_opt_list
	: alterdb_opt_list alterdb_opt_item 
						
	| /* empty */ 
						
	;

copy_generic_opt_arg_list
	: copy_generic_opt_arg_list_item 
						
	| copy_generic_opt_arg_list SQL_COMMA copy_generic_opt_arg_list_item 
						
	;

opt_lock
	: IN_P lock_type MODE 
						
	| FOR lock_type 
						
	| IN_P lock_type 
						
	| FOR lock_type MODE 
						
	| /* empty */ 
						
	;

ExplainableStmt
	: SelectStmt 
						
	| InsertStmt 
						
	| UpdateStmt 
						
	| DeleteStmt 
						
	| DeclareCursorStmt 
						
	| CreateAsStmt 
						
	| ExecuteStmt 
						
	;

opt_existing_window_name
	: ColId 
						
	| %prec Op 
						
	;

columnDef
	: ColId Typename create_generic_options ColQualList 
						
	;

opt_timezone
	: WITH_TIME ZONE 
						
	| WITHOUT TIME ZONE 
						
	| /* empty */ 
						
	;

SelectStmt
	: select_no_parens %prec UMINUS 
						
	| select_with_parens %prec UMINUS 
						
	;

opt_column
	: COLUMN 
						
	| /* empty */ 
						
	;

ForeignTableElement
	: columnDef 
						
	;

opt_charset
	: CHARACTER SET ColId 
						
	
	| CHARACTER SET TD_CharacterSetTypes OptCasespecific 
								
	| /* empty */ 
						
	;

OptCasespecific 
	: CASESPECIFIC 
								
	| NOT CASESPECIFIC

	| /* empty */ 
	/* cause a s/r conflict */
	;					

opt_frame_clause
	: RANGE frame_extent 
						
	| ROWS frame_extent 
						
	| /* empty */ 
						
	;

ExistingIndex
	: USING INDEX index_name 
						
	;

for_locking_item
	: FOR UPDATE locked_rels_list opt_nowait 
						
	| FOR SHARE locked_rels_list opt_nowait 
						
	;

select_offset_value
	: a_expr 
						
	;

returning_clause
	: RETURNING target_list 
						
	| /* empty */ 
						
	;

RuleStmt
	: CREATE opt_or_replace RULE name AS ON event TO qualified_name where_clause DO opt_instead RuleActionList 
						
	;

var_value
	: opt_boolean_or_string 
						
	| NumericOnly 
						
	;

qual_all_Op
	: all_Op 
						
	| OPERATOR SQL_LP any_operator SQL_RP 
						
	;

drop_type
	: TABLE 
						
	| SEQUENCE 
						
	| VIEW 
						
	| INDEX 
						
	| FOREIGN TABLE 
						
	| EVENT TRIGGER 
						
	| TYPE_P 
						
	| DOMAIN_P 
						
	| COLLATION 
						
	| CONVERSION_P 
						
	| SCHEMA 
						
	| EXTENSION 
						
	| TEXT_P SEARCH PARSER 
						
	| TEXT_P SEARCH DICTIONARY 
						
	| TEXT_P SEARCH TEMPLATE 
						
	| TEXT_P SEARCH CONFIGURATION 
						
	;

name_list
	: name 
						
	| name_list SQL_COMMA name 
						
	;

opt_if_exists
	: IF_P EXISTS 
						
	| /* empty */ 
						
	;

opt_restrict
	: RESTRICT 
						
	| /* empty */ 
						
	;

DropOpClassStmt
	: DROP OPERATOR CLASS any_name USING access_method opt_drop_behavior 
						
	| DROP OPERATOR CLASS IF_P EXISTS any_name USING access_method opt_drop_behavior 
						
	;

ctext_expr_list
	: ctext_expr 
						
	| ctext_expr_list SQL_COMMA ctext_expr 
						
	;

InsertStmt
	: opt_with_clause INSERT INTO qualified_name insert_rest returning_clause 
						
	| opt_with_clause INSERT qualified_name insert_rest returning_clause 
			
	;

dostmt_opt_item
	: Sconst 
						
	| LANGUAGE ColId_or_Sconst 
						
	;

opt_xml_root_standalone
	: SQL_COMMA STANDALONE_P YES_P 
						
	| SQL_COMMA STANDALONE_P NO 
						
	| SQL_COMMA STANDALONE_P NO VALUE_P 
						
	| /* empty */ 
						
	;

OptTemp
	: TEMPORARY 
						
	| TEMP 
						
	| LOCAL TEMPORARY 
						
	| LOCAL TEMP 
						
	| GLOBAL TEMPORARY 
						
	| GLOBAL TEMP 
						
	| UNLOGGED 
						
	| VOLATILE 
						
	| /* empty */ 
						
	;

DropForeignServerStmt
	: DROP SERVER name opt_drop_behavior 
						
	| DROP SERVER IF_P EXISTS name opt_drop_behavior 
						
	;

DropAssertStmt
	: DROP ASSERTION name opt_drop_behavior 
						
	;

UnlistenStmt
	: UNLISTEN ColId 
						
	| UNLISTEN SQL_MUL 
						
	;