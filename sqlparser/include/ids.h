/*
 * File: ids.h
 * Author: Wei Tong 
 * 
 * IDENTIFICATION
 * 		sqlparser/include/ids.h
 */


#ifndef __SQLPARSER_INCLUDE_IDS_H__
#define __SQLPARSER_INCLUDE_IDS_H__

enum __ids {
	ID_NOTIFYSTMT,
	ID_OPT_INSTEAD,
	ID_VIEWSTMT,
	ID_KEY_MATCH,
	ID_DROPRULESTMT,
	ID_ATTRS,
	ID_ROW,
	ID_OVERLAY_PLACING,
	ID_SUBQUERY_OP,
	ID_SIMPLETYPENAME,
	ID_OPT_ASYMMETRIC,
	ID_OPT_FOREIGN_SERVER_VERSION,
	ID_CAST_CONTEXT,
	ID_ALTER_EXTENSION_OPT_ITEM,
	ID_OPT_OR_REPLACE,
	ID_INDEX_PARAMS,
	ID_TRANSACTIONSTMT,
	ID_C_EXPR,
	ID_CREATEDB_OPT_LIST,
	ID_DEF_LIST,
	ID_POSITION_LIST,
	ID_INTO_CLAUSE,
	ID_OPT_VALIDATOR,
	ID_DECLARECURSORSTMT,
	ID_SET_CLAUSE_LIST,
	ID_VARIABLESETSTMT,
	ID_ALTERFDWSTMT,
	ID_TRANSACTION_MODE_ITEM,
	ID_CREATESCHEMASTMT,
	ID_ALTERFOREIGNSERVERSTMT,
	ID_PRIVILEGE_LIST,
	ID_COPY_FILE_NAME,
	ID_CREATEOPCLASSSTMT,
	ID_EVENT_TRIGGER_WHEN_ITEM,
	ID_XML_ATTRIBUTE_LIST,
	ID_ALTEROPTROLELIST,
	ID_ALTER_GENERIC_OPTION_LIST,
	ID_CTE_LIST,
	ID_CASE_DEFAULT,
	ID_STMT,
	ID_CURSOR_OPTIONS,
	ID_USING_CLAUSE,
	ID_OPT_DISTINCT,
	ID_CURSOR_NAME,
	ID_WHEN_CLAUSE_LIST,
	ID_EVENT_TRIGGER_VALUE_LIST,
	ID_INDIRECTION_EL,
	ID_BITWITHOUTLENGTH,
	ID_SETRESETCLAUSE,
	ID_COLUMNOPTIONS,
	ID_INDIRECTION,
	ID_OPT_GRANT_GRANT_OPTION,
	ID_ALTERDATABASESTMT,
	ID_COPY_OPT_LIST,
	ID_REMOVEAGGRSTMT,
	ID_ALTERDB_OPT_ITEM,
	ID_DROPDBSTMT,
	ID_OPTINHERIT,
	ID_TRANSACTION_MODE_LIST_OR_EMPTY,
	ID_CLUSTER_INDEX_SPECIFICATION,
	ID_FOREIGNTABLEELEMENTLIST,
	ID_OPT_HOLD,
	ID_DROPOWNEDSTMT,
	ID_SUB_TYPE,
	ID_CREATE_AS_TARGET,
	ID_TABLE_FUNC_COLUMN,
	ID_DEFACLOPTIONLIST,
	ID_XMLEXISTS_ARGUMENT,
	ID_QUALIFIED_NAME,
	ID_ENABLE_TRIGGER,
	ID_WHEN_CLAUSE,
	ID_NOTIFY_PAYLOAD,
	ID_ALTERDOMAINSTMT,
	ID_TABLEELEMENT,
	ID_CREATEDOMAINSTMT,
	ID_OPT_BINARY,
	ID_JOIN_TYPE,
	ID_OPT_OIDS,
	ID_TABLEFUNCELEMENT,
	ID_CREATEROLESTMT,
	ID_COPYSTMT,
	ID_FUNC_AS,
	ID_SELECT_WITH_PARENS,
	ID_SELECT_CLAUSE,
	ID_HAVING_CLAUSE,
	ID_COLQUALLIST,
	ID_ALTEREVENTTRIGSTMT,
	ID_DEFACLOPTION,
	ID_FDW_OPTION,
	ID_OPTSEQOPTLIST,
	ID_OPT_NAME_LIST,
	ID_CONSTTYPENAME,
	ID_ALTER_COLUMN_DEFAULT,
	ID_EXCLUSIONCONSTRAINTELEM,
	ID_VAR_LIST,
	ID_CREATETABLESPACESTMT,
	ID_OPT_WITH_CLAUSE,
	ID_RENAMESTMT,
	ID_FUNC_ARGS_LIST,
	ID_ONCOMMITOPTION,
	ID_INTERVAL_SECOND,
	ID_FUNC_NAME,
	ID_ARG_CLASS,
	ID_COLID_OR_SCONST,
	ID_FROM_CLAUSE,
	ID_TYPE_FUNCTION_NAME,
	ID_LOCK_TYPE,
	ID_SELECT_LIMIT,
	ID_OPT_PROVIDER,
	ID_CONSTRAINTS_SET_LIST,
	ID_OPT_FOR_LOCKING_CLAUSE,
	ID_DROPTABLESPACESTMT,
	ID_RELOPTIONS,
	ID_SEQOPTELEM,
	ID_ALTERSEQSTMT,
	ID_OPT_GRANTED_BY,
	ID_ARRAY_EXPR,
	ID_OPT_FROM_IN,
	ID_ICONST,
	ID_COMMON_FUNC_OPT_ITEM,
	ID_FUNC_ARG_WITH_DEFAULT,
	ID_TRIGGERACTIONTIME,
	ID_PRIVILEGES,
	ID_ALTERROLESETSTMT,
	ID_OPT_TABLE,
	ID_WHERE_CLAUSE,
	ID_TABLELIKECLAUSE,
	ID_OPTFOREIGNTABLEELEMENTLIST,
	ID_OPTTABLESPACEOWNER,
	ID_FUNC_ALIAS_CLAUSE,
	ID_OPT_WITH_DATA,
	ID_SORT_CLAUSE,
	ID_CREATEFUNC_OPT_LIST,
	ID_OPT_DEFINITION,
	ID_KEY_UPDATE,
	ID_CREATETRIGSTMT,
	ID_SUBSTR_LIST,
	ID_CREATEFDWSTMT,
	ID_WHERE_OR_CURRENT_CLAUSE,
	ID_ZONE_VALUE,
	ID_TRIGGERONEEVENT,
	ID_OPT_SET_DATA,
	ID_REVOKESTMT,
	ID_OPT_ASC_DESC,
	ID_VARIABLESHOWSTMT,
	ID_PRIVILEGE_TARGET,
	ID_COPY_OPTIONS,
	ID_DROPUSERSTMT,
	ID_RULEACTIONLIST,
	ID_CREATEOPTROLEELEM,
	ID_ALTERROLESTMT,
	ID_OPT_FULL,
	ID_ALTERDATABASESETSTMT,
	ID_CREATEFUNCTIONSTMT,
	ID_FROM_IN,
	ID_REVOKEROLESTMT,
	ID_OPT_CONCURRENTLY,
	ID_TABLEELEMENTLIST,
	ID_OFFSET_CLAUSE,
	ID_OPT_PARTITION_CLAUSE,
	ID_NAME,
	ID_OPT_IN_DATABASE,
	ID_SELECT_LIMIT_VALUE,
	ID_TRIGGERFOROPTEACH,
	ID_GENERIC_OPTION_ELEM,
	ID_CTEXT_EXPR,
	ID_OPT_TRUSTED,
	ID_SELECT_OFFSET_VALUE2,
	ID_COPY_GENERIC_OPT_ARG_LIST_ITEM,
	ID_EXPR_LIST,
	ID_ALTERTSDICTIONARYSTMT,
	ID_DEFACLACTION,
	ID_DEALLOCATESTMT,
	ID_COPY_OPT_ITEM,
	ID_TYPE_FUNC_NAME_KEYWORD,
	ID_EVENT,
	ID_OPCLASS_PURPOSE,
	ID_EXPLAIN_OPTION_LIST,
	ID_OPT_WITH,
	ID_ALTERFOREIGNTABLESTMT,
	ID_ALTER_USING,
	ID_COL_NAME_KEYWORD,
	ID_COLUMNREF,
	ID_ROLEID,
	ID_DROPCASTSTMT,
	ID_NUMERICONLY_LIST,
	ID_WINDOW_CLAUSE,
	ID_CLUSTERSTMT,
	ID_TYPENAME,
	ID_ADD_DROP,
	ID_OLD_AGGR_DEFINITION,
	ID_EXCLUSIONCONSTRAINTLIST,
	ID_OPT_FDW_OPTIONS,
	ID_COLID,
	ID_OPTSCHEMAELTLIST,
	ID_NUMERIC,
	ID_CHARACTERWITHLENGTH,
	ID_FUNCTION_WITH_ARGTYPES_LIST,
	ID_INDEX_ELEM,
	ID_DEFINITION,
	ID_SEQOPTLIST,
	ID_ENUM_VAL_LIST,
	ID_OPT_SELECT_LIMIT,
	ID_QUALIFIED_NAME_LIST,
	ID_ALTER_TABLE_CMDS,
	ID_DROPOPFAMILYSTMT,
	ID_RULEACTIONMULTI,
	ID_AGGR_ARGS,
	ID_DEF_ARG,
	ID_EXPLAIN_OPTION_ELEM,
	ID_FUNC_ARG,
	ID_OPT_INLINE_HANDLER,
	ID_OPT_NO_INHERIT,
	ID_OPT_PROCEDURAL,
	ID_INSERT_REST,
	ID_FDW_OPTIONS,
	ID_DELETESTMT,
	ID_TRIGGERFORTYPE,
	ID_DROPROLESTMT,
	ID_GENERIC_OPTION_ARG,
	ID_FETCHSTMT,
	ID_OPT_CLASS,
	ID_CONSTRAINTS_SET_MODE,
	ID_ANY_NAME_LIST,
	ID_ACCESS_METHOD,
	ID_TABLECONSTRAINT,
	ID_RULEACTIONSTMT,
	ID_CONSTCHARACTER,
	ID_JOIN_QUAL,
	ID_LOCKSTMT,
	ID_TABLEFUNCELEMENTLIST,
	ID_TARGET_EL,
	ID_VALIDATOR_CLAUSE,
	ID_FUNCTION_WITH_ARGTYPES,
	ID_OPT_FLOAT,
	ID_ALIAS_CLAUSE,
	ID_FUNC_ARGS,
	ID_CASE_EXPR,
	ID_FILE_NAME,
	ID_FOR_LOCKING_ITEMS,
	ID_MULTIPLE_SET_CLAUSE,
	ID_OPT_FORCE,
	ID_GROUP_CLAUSE,
	ID_OPT_ALIAS_CLAUSE,
	ID_CREATEFUNC_OPT_ITEM,
	ID_OPT_RECHECK,
	ID_TYPEDTABLEELEMENT,
	ID_OPTTABLEFUNCELEMENTLIST,
	ID_CREATEPLANGSTMT,
	ID_ALTERCOMPOSITETYPESTMT,
	ID_ALTERENUMSTMT,
	ID_FUNC_TYPE,
	ID_COPY_DELIMITER,
	ID_CHECKPOINTSTMT,
	ID_OPT_ALL,
	ID_KEY_ACTIONS,
	ID_CREATEOPFAMILYSTMT,
	ID_OPT_COLUMN_LIST,
	ID_LISTENSTMT,
	ID_OPTCONSTRFROMTABLE,
	ID_WINDOW_SPECIFICATION,
	ID_VALUES_CLAUSE,
	ID_BITWITHLENGTH,
	ID_FROM_LIST,
	ID_ALTERDEFAULTPRIVILEGESSTMT,
	ID_CHARACTER,
	ID_CHARACTER_BIG,
	ID_REMOVEOPERSTMT,
	ID_ALTEROBJECTSCHEMASTMT,
	ID_SORTBY_LIST,
	ID_COLCONSTRAINTELEM,
	ID_REINDEX_TYPE,
	ID_CREATESEQSTMT,
	ID_CREATECASTSTMT,
	ID_AUTH_IDENT,
	ID_SUBSTR_FROM,
	ID_UNRESERVED_KEYWORD,
	ID_DOCUMENT_OR_CONTENT,
	ID_BIT,
	ID_ALTER_GENERIC_OPTIONS,
	ID_OPT_NULLS_ORDER,
	ID_OPT_DEFAULT,
	ID_FIRST_OR_NEXT,
	ID_OLD_AGGR_ELEM,
	ID_OPT_COLLATE_CLAUSE,
	ID_TRUNCATESTMT,
	ID_ALTERFUNC_OPT_LIST,
	ID_ATTR_NAME,
	ID_ALTER_EXTENSION_OPT_LIST,
	ID_PREPARESTMT,
	ID_OPER_ARGTYPES,
	ID_DISCARDSTMT,
	ID_CREATESTMT,
	ID_SECURITY_LABEL_TYPE,
	ID_ALL_OP,
	ID_FUNC_ARG_EXPR,
	ID_CREATECONVERSIONSTMT,
	ID_FUNC_ARGS_WITH_DEFAULTS,
	ID_ALTERUSERMAPPINGSTMT,
	ID_TABLELIKEOPTIONLIST,
	ID_EXCLUSIONWHERECLAUSE,
	ID_CONSTRAINTSSETSTMT,
	ID_OPT_GRANT_ADMIN_OPTION,
	ID_OPT_TYPE_MODIFIERS,
	ID_CONSTBIT,
	ID_CREATEEVENTTRIGSTMT,
	ID_SET_TARGET_LIST,
	ID_OVERLAY_LIST,
	ID_FUNC_TABLE,
	ID_CREATEUSERMAPPINGSTMT,
	ID_ALTERFUNCTIONSTMT,
	ID_OPT_AS,
	ID_SINGLE_SET_CLAUSE,
	ID_FUNC_EXPR,
	ID_OPCLASS_DROP,
	ID_AEXPRCONST,
	ID_XML_ATTRIBUTES,
	ID_REASSIGNOWNEDSTMT,
	ID_ACCESS_METHOD_CLAUSE,
	ID_COPY_GENERIC_OPT_LIST,
	ID_COLUMNLIST,
	ID_TYPEDTABLEELEMENTLIST,
	ID_OPT_VARYING,
	ID_A_EXPR,
	ID_ALTER_GENERIC_OPTION_ELEM,
	ID_WITH_CLAUSE,
	ID_PREPARABLESTMT,
	ID_DEF_ELEM,
	ID_ALTEROWNERSTMT,
	ID_CREATEFOREIGNSERVERSTMT,
	ID_DATABASE_NAME,
	ID_CREATEGROUPSTMT,
	ID_OPT_RESTART_SEQS,
	ID_OPT_SELECT_FETCH_FIRST_VALUE,
	ID_ROW_OR_ROWS,
	ID_OPT_ARRAY_BOUNDS,
	ID_OPT_INDIRECTION,
	ID_ALTEROPFAMILYSTMT,
	ID_CONSTRAINTATTR,
	ID_COLUMNELEM,
	ID_OPT_INDEX_NAME,
	ID_STMTBLOCK,
	ID_FUNC_RETURN,
	ID_CREATE_GENERIC_OPTIONS,
	ID_SECLABELSTMT,
	ID_GENERIC_OPTION_NAME,
	ID_XML_WHITESPACE_OPTION,
	ID_VAR_NAME,
	ID_PRIVILEGE,
	ID_TABLE_REF,
	ID_EXTRACT_LIST,
	ID_OLD_AGGR_LIST,
	ID_COMMENTSTMT,
	ID_GRANTEE_LIST,
	ID_CONSTRAINTATTRIBUTESPEC,
	ID_OVER_CLAUSE,
	ID_FRAME_BOUND,
	ID_KEY_DELETE,
	ID_KEY_ACTION,
	ID_RELATION_EXPR_OPT_ALIAS,
	ID_JOIN_OUTER,
	ID_SET_CLAUSE,
	ID_DROPTRIGSTMT,
	ID_ALTEREXTENSIONCONTENTSSTMT,
	ID_CONSTDATETIME,
	ID_OPCLASS_ITEM,
	ID_RELOPTION_LIST,
	ID_OPT_TRANSACTION,
	ID_XML_ROOT_VERSION,
	ID_EXTRACT_ARG,
	ID_ANY_OPERATOR,
	ID_SORTBY,
	ID_OPT_ENUM_VAL_LIST,
	ID_TRIM_LIST,
	ID_SUBSTR_FOR,
	ID_OPT_SORT_CLAUSE,
	ID_LIMIT_CLAUSE,
	ID_CHARACTERWITHOUTLENGTH,
	ID_VACUUM_OPTION_ELEM,
	ID_STMTMULTI,
	ID_ALTER_TABLE_CMD,
	ID_IN_EXPR,
	ID_INDEX_NAME,
	ID_ALTERUSERSETSTMT,
	ID_OPT_TYPE,
	ID_OPTTYPEDTABLEELEMENTLIST,
	ID_CREATEASSTMT,
	ID_DROPUSERMAPPINGSTMT,
	ID_RESERVED_KEYWORD,
	ID_SET_REST,
	ID_LOADSTMT,
	ID_EXPLAIN_OPTION_ARG,
	ID_DROPGROUPSTMT,
	ID_OPT_CHECK_OPTION,
	ID_TRIGGEREVENTS,
	ID_GRANTEE,
	ID_ANY_NAME,
	ID_TRIGGERFORSPEC,
	ID_MATHOP,
	ID_OPTTABLEELEMENTLIST,
	ID_COLCONSTRAINT,
	ID_TRIGGERWHEN,
	ID_EXPLAINSTMT,
	ID_OPT_VERBOSE,
	ID_VACUUM_OPTION_LIST,
	ID_DEFACL_PRIVILEGE_TARGET,
	ID_ALTERTABLESTMT,
	ID_OPT_ENCODING,
	ID_CREATEEXTENSIONSTMT,
	ID_TYPE_LIST,
	ID_HANDLER_NAME,
	ID_CREATEFOREIGNTABLESTMT,
	ID_OPT_NOWAIT,
	ID_COMMON_TABLE_EXPR,
	ID_OPT_USING,
	ID_OPTSCHEMANAME,
	ID_OPT_DROP_BEHAVIOR,
	ID_XML_ATTRIBUTE_EL,
	ID_COPY_FROM,
	ID_DEFINESTMT,
	ID_CREATEDBSTMT,
	ID_SET_REST_MORE,
	ID_SIGNEDICONST,
	ID_OPTWITH,
	ID_ALTER_TYPE_CMDS,
	ID_INSERT_COLUMN_LIST,
	ID_SCHEMA_STMT,
	ID_FRAME_EXTENT,
	ID_ANALYZESTMT,
	ID_GRANTSTMT,
	ID_TABLE_FUNC_COLUMN_LIST,
	ID_OPT_RELOPTIONS,
	ID_CREATEASSERTSTMT,
	ID_OPTTEMPTABLENAME,
	ID_OPT_FREEZE,
	ID_FUNC_ARGS_WITH_DEFAULTS_LIST,
	ID_OPTCONSTABLESPACE,
	ID_ALTERTSCONFIGURATIONSTMT,
	ID_REMOVEFUNCSTMT,
	ID_EXPLAIN_OPTION_NAME,
	ID_CREATEDB_OPT_ITEM,
	ID_WINDOW_DEFINITION,
	ID_OPCLASS_ITEM_LIST,
	ID_NUMERICONLY,
	ID_ARRAY_EXPR_LIST,
	ID_OPT_BY,
	ID_PARAM_NAME,
	ID_JOINED_TABLE,
	ID_TABLELIKEOPTION,
	ID_CREATE_EXTENSION_OPT_ITEM,
	ID_FETCH_ARGS,
	ID_SELECT_NO_PARENS,
	ID_LOCKED_RELS_LIST,
	ID_FOREIGN_SERVER_VERSION,
	ID_UPDATESTMT,
	ID_OPT_BOOLEAN_OR_STRING,
	ID_TRIGGERFUNCARG,
	ID_OPT_UNIQUE,
	ID_SIMPLE_SELECT,
	ID_WINDOW_DEFINITION_LIST,
	ID_TRANSACTION_MODE_LIST,
	ID_CONSTRAINTELEM,
	ID_CREATEUSERSTMT,
	ID_TRIGGERFUNCARGS,
	ID_RELOPTION_ELEM,
	ID_CASE_ARG,
	ID_B_EXPR,
	ID_SET_TARGET,
	ID_VACUUMSTMT,
	ID_ALTERGROUPSTMT,
	ID_PREP_TYPE_CLAUSE,
	ID_ANALYZE_KEYWORD,
	ID_OPTROLELIST,
	ID_COMMENT_TEXT,
	ID_ALTEROPTROLEELEM,
	ID_SCONST,
	ID_OPCLASS_DROP_LIST,
	ID_DROPPLANGSTMT,
	ID_COPY_GENERIC_OPT_ELEM,
	ID_DOSTMT,
	ID_CREATE_EXTENSION_OPT_LIST,
	ID_COLLABEL,
	ID_DROPSTMT,
	ID_GENERIC_OPTION_LIST,
	ID_OPTTABLESPACE,
	ID_GRANTROLESTMT,
	ID_DROPFDWSTMT,
	ID_INDEXSTMT,
	ID_FOR_LOCKING_CLAUSE,
	ID_COMMENT_TYPE,
	ID_FUNC_ARG_LIST,
	ID_ISO_LEVEL,
	ID_CTEXT_ROW,
	ID_EVENT_TRIGGER_WHEN_LIST,
	ID_OPT_INTERVAL,
	ID_TARGET_LIST,
	ID_SECURITY_LABEL,
	ID_VARIABLERESETSTMT,
	ID_CONSTINTERVAL,
	ID_REINDEXSTMT,
	ID_GENERICTYPE,
	ID_OPT_OPFAMILY,
	ID_FUNCTIONSETRESETCLAUSE,
	ID_CLOSEPORTALSTMT,
	ID_ALTERUSERSTMT,
	ID_EXECUTESTMT,
	ID_EXECUTE_PARAM_CLAUSE,
	ID_COPY_GENERIC_OPT_ARG,
	ID_ALTEREXTENSIONSTMT,
	ID_ALTER_TYPE_CMD,
	ID_OPT_EQUAL,
	ID_OPT_COLLATE,
	ID_INSERT_COLUMN_ITEM,
	ID_DOSTMT_OPT_LIST,
	ID_CONSTRAINTATTRIBUTEELEM,
	ID_RELATION_EXPR_LIST,
	ID_RULEACTIONSTMTOREMPTY,
	ID_QUAL_OP,
	ID_RELATION_EXPR,
	ID_ALTERDB_OPT_LIST,
	ID_COPY_GENERIC_OPT_ARG_LIST,
	ID_OPT_LOCK,
	ID_EXPLAINABLESTMT,
	ID_OPT_EXISTING_WINDOW_NAME,
	ID_COLUMNDEF,
	ID_OPT_TIMEZONE,
	ID_SELECTSTMT,
	ID_OPT_COLUMN,
	ID_FOREIGNTABLEELEMENT,
	ID_OPT_CHARSET,
	ID_OPT_FRAME_CLAUSE,
	ID_EXISTINGINDEX,
	ID_FOR_LOCKING_ITEM,
	ID_SELECT_OFFSET_VALUE,
	ID_RETURNING_CLAUSE,
	ID_RULESTMT,
	ID_VAR_VALUE,
	ID_QUAL_ALL_OP,
	ID_DROP_TYPE,
	ID_NAME_LIST,
	ID_OPT_IF_EXISTS,
	ID_OPT_RESTRICT,
	ID_DROPOPCLASSSTMT,
	ID_CTEXT_EXPR_LIST,
	ID_INSERTSTMT,
	ID_DOSTMT_OPT_ITEM,
	ID_OPT_XML_ROOT_STANDALONE,
	ID_OPTTEMP,
	ID_DROPFOREIGNSERVERSTMT,
	ID_DROPASSERTSTMT,
	ID_UNLISTENSTMT,
	ID_OPT_INDEX_DEFINITION,

	/* new nodes */
	ID_IDENT,
	ID_COLLECTSTATISTICSSTMT,
	ID_COLUMNREF_LIST,
	ID_SAMPLE_CLAUSE,
	ID_SAMPLE_DEFAULT,
	ID_CREATESYSOPTIONLIST,
	ID_FALLBACK_OPTION,
	ID_LOG_OPTION,
	ID_FREESPACE_OPTION,
	ID_JOURNAL_OPTION,
	ID_CREATESYSOPTION,
	ID_PAREN_FUNC_EXPR,
	ID_RELATION_EXPR_OPT_ALIAS_LIST,
	ID_FORMAT_CLAUSE,
	ID_OPTCASESPECIFIC,
	ID_TD_TRANS_DATE_TIME,
	ID_INTERVAL_DAY,
	ID_INTERVAL_HOUR,
	ID_TD_COMMAND,
	ID_DATABASECOMMAND,
	ID_OPTSETMULTISET
};

#endif // __SQLPARSER_INCLUDE_IDS_H__