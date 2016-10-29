#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>
#include <usrinc/atmi.h>
#include <usrinc/tmaxapi.h>
#include <usrinc/tmadmin.h>

#include <netinet/in.h>
#include <arpa/inet.h>

/* In this example, we assume maximum 16 nodes */
#define MAX_NODE	32
#define MAX_SIZE	(1024*1024)

char data[MAX_SIZE];	/* 1MB of buffer */



/*
+---------------------------------------------------------------+
|  * Tmax Info [ti]                                             |
+---------------------------------------------------------------+
*/
int
tmaxinfo(char **buf)
{	
	int i, n, tmp, size, num_node;
	int major, minor, patch;
	int year, month, day;
	struct tmadm_tmax_info *info;

	size = sizeof(struct tmadm_tmax_info) + 
	    (MAX_NODE - 1) * sizeof (struct tmadm_node_summary);
	info = (struct tmadm_tmax_info *) malloc(size);
	if (info == NULL)
	    return -1;

	memset(info, 0x00, size);
	info->header.version = _TMADMIN_VERSION;
	info->header.size = size;
	n = tmadmin(TMADM_TMAX_INFO, info, 0, 0);
	if (n < 0) {
	    free(info);
	    return -1;
	}
/*
printf("info->header.version    		[%d]\n",info->header.version    		);
printf("info->header.size			[%d]\n",info->header.size			);
printf("info->header.offset			[%d]\n",info->header.offset			);
printf("info->header.num_entry			[%d]\n",info->header.num_entry			);
printf("info->header.num_left			[%d]\n",info->header.num_left			);
printf("info->header.opt_int			[%d]\n",info->header.opt_int			);
printf("info->header.reserve_int[0]		[%d]\n",info->header.reserve_int[0]		);
printf("info->header.reserve_int[1]		[%d]\n",info->header.reserve_int[1]		);
printf("info->header.opt_char[TMAX_NAME_SIZE]   [%s]\n",info->header.opt_char			);
*/
/*
         "Tmax System Info		: DEMO version 3.8.17:
         "expiration date 		= 2004/1/3
         "maxuser 		= UNLIMITED,
         "domaincount 		= 1,
         "nodecount 		= 1,
         "svgrpcount 		= 3,
         "svrcount 		= 114, 
         "svccount 		= 834
         "rout_groupcount 	= 0, 
         "rout_elemcount 	= 0
         "cousin_groupcount 	= 0, 
         "cousin_elemcount 	= 0
         "backup_groupcount 	= 0, 
         "backup_elemcount 	= 0

Tmax All Node Info: nodecount = 1:
------------------------------------------------------------------
  no   name     portno  racport  shmkey  shmsize  minclh  maxclh
------------------------------------------------------------------
*/
	/* title make */
	sprintf(data,   "T["\
			"TmaxSystemInfo|"\
			"version|"\
			"expirationdate|"\
			"maxuser|"\
			"domaincount|"\
			"nodecount|"\
			"svgrpcount|"\
			"svrcount|"\
			"svccount|"\
			"rout_groupcount|"\
			"rout_elemcount|"\
			"cousin_groupcount|"\
			"cousin_elemcount|"\
			"backup_groupcount|"\
			"backup_elemcount|"\
			"prod_count|"\
			"func_count|"\
			"]T");
/*
printf("info->body.sysinfo	[%d]\n",info->body.sysinfo	); 
printf("info->body.version	[%d]\n",info->body.version	); 
printf("info->body.expdate	[%d]\n",info->body.expdate	); 
printf("info->body.maxuser	[%d]\n",info->body.maxuser	); 
printf("info->body.nodecount    [%d]\n",info->body.nodecount    ); 
printf("info->body.svgcount     [%d]\n",info->body.svgcount     ); 
printf("info->body.svrcount     [%d]\n",info->body.svrcount     ); 
printf("info->body.svccount     [%d]\n",info->body.svccount     ); 
printf("info->body.rqcount      [%d]\n",info->body.rqcount      ); 
printf("info->body.gwcount      [%d]\n",info->body.gwcount      ); 
printf("info->body.rout_gcount	[%d]\n",info->body.rout_gcount	); 
printf("info->body.rout_count   [%d]\n",info->body.rout_count   ); 
printf("info->body.cousin_gcount[%d]\n",info->body.cousin_gcount);
printf("info->body.cousin_count [%d]\n",info->body.cousin_count );
printf("info->body.backup_gcount[%d]\n",info->body.backup_gcount);
printf("info->body.backup_count [%d]\n",info->body.backup_count ); 
printf("info->body.prod_count   [%d]\n",info->body.prod_count   ); 
printf("info->body.func_count   [%d]\n",info->body.func_count   ); 
printf("info->body.reserve[0]   [%d]\n",info->body.reserve[0]   ); 
printf("info->body.reserve[1]   [%d]\n",info->body.reserve[1]   ); 
printf("info->body.reserve[2]   [%d]\n",info->body.reserve[2]   ); 
printf("info->body.reserve[3]   [%d]\n",info->body.reserve[3]   ); 
printf("info->body.reserve[4]   [%d]\n",info->body.reserve[4]   ); 
printf("info->body.reserve[5]   [%d]\n",info->body.reserve[5]   ); 
*/

	/* pack message */
	major = info->body.version / 10000;
	tmp = info->body.version % 10000;
	minor = tmp / 100;
	patch = tmp % 100;

	n = strlen(data);
	if (info->body.expdate == 0) {	/* Real Version */
	        sprintf(data+n, "D[REAL|%2d.%2d.%2d|%4d%02d%02d%s",
					 major, minor, patch, NULL, NULL, NULL, "|");

        /*=============================================================
	    sprintf(data, "\nTmax System Info: REAL version %d.%d.%d:\n\n",
		    major, minor, patch);
        ===============================================================*/
	} else {	/* Demo Version */
	    year = info->body.expdate / 10000;
	    tmp = info->body.expdate % 10000;
	    month = tmp / 100;
	    day = tmp % 100;

	        sprintf(data+n,"D[DEMO|%2d.%2d.%2d|%4d%02d%02d%s",
                			major,minor,patch, year, month, day,"|");

    
	        /*=============================================================
		    sprintf(data, 
			"\nTmax System Info: DEMO version %d.%d.%d:\n\n"
			"\t expiration date = %d/%d/%d\n",
			major, minor, patch, year, month, day);
	        ===============================================================*/
	}

	n = strlen(data);
	if (info->body.maxuser > 0)
        	sprintf(data + n, "%d%s", info->body.maxuser,"|");
	else
        	sprintf(data + n, "UNLIMITED|");

    /*=============================================================
	if (info->body.maxuser > 0)
	    sprintf(data + n, "\t maxuser = %d\n", info->body.maxuser);
	else
	    sprintf(data + n, "\t maxuser = UNLIMITED\n");
    ===============================================================*/

	n = strlen(data);
    	sprintf(data + n,
        "%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|#]D",
        info->body.nodecount,
        info->body.svgcount,
        info->body.svrcount,
        info->body.svccount,
        info->body.rqcount,
        info->body.gwcount,
        info->body.rout_gcount,
        info->body.rout_count,
        info->body.cousin_gcount,
        info->body.cousin_count,
        info->body.backup_gcount,
        info->body.backup_count,
        info->body.prod_count,
        info->body.func_count);

    /*=============================================================
	sprintf(data + n,
	    "\t nodecount = %d\n"
	    "\t svgrpcount = %d\n"
	    "\t svrcount = %d, svccount = %d\n"
	    "\t rqcount = %d, gwcount = %d\n"
	    "\t rout_groupcount = %d, rout_elemcount = %d\n"
	    "\t cousin_groupcount = %d, cousin_elemcount = %d\n"
	    "\t backup_groupcount = %d, backup_elemcount = %d\n"
	    "\t prod_count = %d, func_count = %d\n",
	    info->body.nodecount,
	    info->body.svgcount,
	    info->body.svrcount, info->body.svccount,
	    info->body.rqcount, info->body.gwcount,
	    info->body.rout_gcount, info->body.rout_count,
	    info->body.cousin_gcount, info->body.cousin_count,
	    info->body.backup_gcount, info->body.backup_count,
	    info->body.prod_count, info->body.func_count);
    ===============================================================*/

    /*=============================================================
	sprintf(data + n, 
	    "\nTmax All Node Info: nodecount = %d:\n"
	    "------------------------------------------------------------------\n"
	    "  no   name     portno  racport  shmkey  shmsize  minclh  maxclh\n"
	    "------------------------------------------------------------------\n",
	    num_node);
    ===============================================================*/
	n = strlen(data);
	sprintf(data+n, "T["\
			"no|"\
			"name|"\
			"portno|"\
			"racport|"\
			"shmkey|"\
			"shmsize|"\
			"minclh|"\
			"maxclh|"\
			"]T");

	n = strlen(data);
	sprintf(data+n, "D[");
	num_node = info->body.nodecount;
	n = strlen(data);
	for (i = 0; i < num_node; i++) {
	    sprintf(data + n, 
        	"%d|%-s|%d|%d|%d|%d|%d|%d|",
		info->node[i].no,
		info->node[i].name,
		info->node[i].port,
		info->node[i].racport,
		info->node[i].shmkey,
		info->node[i].shmsize,
		info->node[i].minclh,
		info->node[i].maxclh);
	    n = strlen(data);
	}
	n = strlen(data);
	sprintf(data+n, "#]D");

	free(info);
	*buf = data;
	return (strlen(data) + 1);
}


/*
+---------------------------------------------------------------+
|  * Domain Info [cfg -d]                                       |
+---------------------------------------------------------------+
*/
int
domainconf(char **buf)
{	
	int i, n, size;
	struct tmadm_domain_conf conf;

	size = sizeof(struct tmadm_domain_conf);
	memset(&conf, 0x00, size);
	conf.header.version = _TMADMIN_VERSION;
	conf.header.size = size;
	n = tmadmin(TMADM_DOMAIN_CONF, &conf, 0, 0);
	if (n < 0)
	    return -1;

	data[0] = '\0';

	n = strlen(data);
	sprintf(data+n, "T["\
                        "domain_id|"\
                        "domain_name|"\
                        "shmkey|"\
                        "minclh|"\
                        "maxclh|"\
                        "maxuser|"\
                        "portno|"\
                        "racport|"\
                        "cmtret|"\
                        "blocktime(bt)|"\
                        "txtime(tt)|"\
                        "nliveinq(ni)|"\
                        "security|"\
                        "cpc|"\
                        "maxfunc|"\
                        "clichkint|"\
                        "idletime|"\
                        "node_count|"\
                        "svg_count|"\
                        "svr_count|"\
                        "cousin_count|"\
                        "cousin_gcount|"\
                        "backup_count|"\
                        "backup_gcount|"\
                        "rout_count|"\
                        "rout_gcount|"\
                        "maxsacall|"\
                        "maxcacall|"\
                        "nclhchkint|"\
                        "maxconv_node|"\
                        "maxconv_server|"\
                        "maxnode|"\
                        "maxsvg|"\
                        "maxspr|"\
                        "maxsvr|"\
                        "maxsvc|"\
                        "maxcpc|"\
                        "maxtms|"\
                        "maxrout|"\
                        "maxroutsvg|"\
                        "maxrq|"\
                        "maxgw|"\
                        "maxcousin|"\
                        "maxcousinsvg|"\
                        "maxbackup|"\
                        "maxcousinsvg|"\
                        "maxbackup|"\
			"]T");

/*
	sprintf(data, "%d\n%d\n%d\n%d\n%d\n%d\n%d\n",
	    conf.body.domain_id,
	    conf.body.minclh,
	    conf.body.maxclh,
	    conf.body.tportno,
	    conf.body.racport,
	    conf.body.blocktime,
	    conf.body.txtime);
*/
	n = strlen(data);
	sprintf(data+n, "D[");
	n = strlen(data);
	sprintf(data+n, "%d|%-s|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|#",
	    conf.body.domain_id, conf.body.name,         conf.body.shmkey,
	    conf.body.minclh,    conf.body.maxclh,       conf.body.maxuser,
	    conf.body.tportno,   conf.body.racport,      conf.body.cpc,
	    conf.body.blocktime, conf.body.txtime,       conf.body.clichkint,
	    conf.body.nliveinq,  conf.body.nclhchkint,   conf.body.cmtret,
	    conf.body.security,  conf.body.maxsacall,    conf.body.maxcacall,
	    conf.body.maxconvn,  conf.body.maxconvs,     conf.body.maxnode,
	    conf.body.maxsvg,    conf.body.maxsvr,       conf.body.maxsvc,
	    conf.body.maxspr,    conf.body.maxtms,       conf.body.maxcpc,
	    conf.body.maxrout,   conf.body.maxroutsvg,   conf.body.maxrq,
	    conf.body.maxgw,     conf.body.maxcousin,    conf.body.maxcousinsvg,
	    conf.body.maxbackup, conf.body.maxbackupsvg, conf.body.maxtotalsvg,
	    conf.body.maxprod,   conf.body.maxfunc );
	    
	n = strlen(data);
	sprintf(data+n, "]D");

	*buf = data;
	return (strlen(data) + 1);
}


/*
+---------------------------------------------------------------+
|  * Node Info [cfg -n]                                         |
+---------------------------------------------------------------+
*/
int
nodeconf(char **buf)
{	
	int i, n, size;
	struct tmadm_node_conf conf;

	size = sizeof(struct tmadm_node_conf);
	memset(&conf, 0x00, size);
	conf.header.version = _TMADMIN_VERSION;
	conf.header.size = size;
	n = tmadmin(TMADM_NODE_CONF, &conf, 0, 0);
	if (n < 0)
	    return -1;

    data[0] = '\0';

	sprintf(data, "%10d|%-16s|%10d|%10d|%10d|%10d|%10d|%10d|%10d|%10d|%10d|%10d|%10d|%20ld|%10d|%10d|%10d|%10d|%10d|%-08d|%-08d|%-08d|%-08d|%-08d|%-08d|%-08d|%-08d|%-08d|%-08d|%-08d|%-08d|%-08d|%-08d|%-08d|%-08d|%-16s|%-16s|%-256s|%-256s|%-256s|%-256s|%-256s|%-256s|%-256s|%10d|%10d|%10d|%10d|%10d|%10d|%10d|%10d|%10d|%10d|%10d|%10d|%10d|%10d|%10d|%10d",
	    conf.body.no,        conf.body.name,        conf.body.shmkey,
	    conf.body.shmsize,   conf.body.minclh,      conf.body.maxclh,
	    conf.body.maxuser,   conf.body.clhqtimeout, conf.body.idletime,
	    conf.body.clichkint, conf.body.racport,     conf.body.rscpc,
	    conf.body.ipcperm,   conf.body.ip,          conf.body.maxsvg,
	    conf.body.maxsvr,    conf.body.maxspr,      conf.body.maxtms,
	    conf.body.maxcpc,    conf.body.scaport[0],  conf.body.scaport[1],
        conf.body.scaport[2],  conf.body.scaport[3],  conf.body.scaport[4],
        conf.body.scaport[5],  conf.body.scaport[6],  conf.body.scaport[7],
        conf.body.tmaxport[0], conf.body.tmaxport[1], conf.body.tmaxport[2],
        conf.body.tmaxport[3], conf.body.tmaxport[4], conf.body.tmaxport[5],
        conf.body.tmaxport[6], conf.body.tmaxport[7], conf.body.logoutsvc,
        conf.body.realsvr,     conf.body.tmaxdir,     conf.body.appdir,
        conf.body.pathdir,     conf.body.tlogdir,     conf.body.slogdir,
        conf.body.ulogdir,     conf.body.envfile,     conf.body.curclh,
        conf.body.clh_maxuser, conf.body.svgcount,    conf.body.svrcount,
        conf.body.svccount,    conf.body.sprcount,    conf.body.clicount[0],
        conf.body.clicount[1], conf.body.clicount[2], conf.body.clicount[3],
        conf.body.clicount[4], conf.body.clicount[5], conf.body.clicount[6],
        conf.body.clicount[7], conf.body.clicount[8], conf.body.clicount[9] );

	*buf = data;
	return (strlen(data) + 1);
}

/*
+---------------------------------------------------------------+
|  * Group Info [cfg -g]                                        |
+---------------------------------------------------------------+
*/
int
svgconf(char **buf)
{
	int i, n, size, svgcount;
	struct tmadm_svg_conf info;
	struct tmadm_svg_conf *conf;

	memset(&info, 0x00, sizeof(struct tmadm_svg_conf));
	info.header.version = _TMADMIN_VERSION;
	info.header.size = sizeof(struct tmadm_svg_conf);
	n = tmadmin(TMADM_SVG_CONF, &info, 0, 0);
	if (n < 0)
	    return -1;

	svgcount = info.header.num_entry + info.header.num_left;
	size = sizeof(struct tmadm_svg_conf) + 
	    (svgcount - 1) * sizeof (struct tmadm_svg_conf_body);
	conf = (struct tmadm_svg_conf *) malloc(size);
	if (conf == NULL)
	    return -1;

	memset(conf, 0x00, size);
	conf->header.version = _TMADMIN_VERSION;
	conf->header.size = size;
	n = tmadmin(TMADM_SVG_CONF, conf, 0, 0);
	if (n < 0) {
	    free(conf);
	    return -1;
	}

    data[0] = '\0';

	n = 0;
	for (i = 0; i < svgcount; i++) {
	    sprintf(data + n, "%10d\t%-16s\t%-16s\t%-16s\t%-16s\t%-16s\t%-256s\t%-256s\t%-256s\t%-256s\t%-256s\t%10d\t%10d\t%10d\t\n",
		    conf->svg[i].no,
		    conf->svg[i].name,
		    conf->svg[i].svgtype,
		    conf->svg[i].owner,
		    conf->svg[i].dbname,
		    conf->svg[i].tmsname,
		    conf->svg[i].appdir,
		    conf->svg[i].ulogdir,
		    conf->svg[i].envfile,
		    conf->svg[i].openinfo,
		    conf->svg[i].closeinfo,
		    conf->svg[i].curtms,
		    conf->svg[i].mintms,
		    conf->svg[i].maxtms);
	   n = strlen(data);
	}

	free(conf);
	*buf = data;
	return (strlen(data) + 1);
}

/*
+---------------------------------------------------------------+
|  * Server Info [cfg -v]                                       |
+---------------------------------------------------------------+
*/
int
svrconf(char **buf)
{
	int i, n, size, svrcount;
	struct tmadm_svr_conf info;
	struct tmadm_svr_conf *conf;

	memset(&info, 0x00, sizeof(struct tmadm_svr_conf));
	info.header.version = _TMADMIN_VERSION;
	info.header.size = sizeof(struct tmadm_svr_conf);
	n = tmadmin(TMADM_SVR_CONF, &info, 0, 0);
	if (n < 0)
	    return -1;

	svrcount = info.header.num_entry + info.header.num_left;
	size = sizeof(struct tmadm_svr_conf) + 
	    (svrcount - 1) * sizeof (struct tmadm_svr_conf_body);
	conf = (struct tmadm_svr_conf *) malloc(size);
	if (conf == NULL)
	    return -1;

	memset(conf, 0x00, size);
	conf->header.version = _TMADMIN_VERSION;
	conf->header.size = size;
	n = tmadmin(TMADM_SVR_CONF, conf, 0, 0);
	if (n < 0) {
	    free(conf);
	    return -1;
	}

    data[0] = '\0';

	n = 0;
	for (i = 0; i < svrcount; i++) {
	    sprintf(data + n, "%10d\t%-16s\t%10d\t%10d\t%10d\t%10d\t%10d\t%10d\t%10d\t%10d\t%10d\t%10d\t%10d\t%-16s\t%-16s\t%-256s\t%-256s\t\n",
		conf->svr[i].no,
		conf->svr[i].name,
        conf->svr[i].svgno,
		conf->svr[i].cursvr,
		conf->svr[i].minsvr,
        conf->svr[i].maxsvr,
        conf->svr[i].conv,
        conf->svr[i].maxqcount,
        conf->svr[i].asqcount,
        conf->svr[i].maxrstart,
        conf->svr[i].gperiod,
        conf->svr[i].restart,
        conf->svr[i].cpc,
        conf->svr[i].target,
        conf->svr[i].svrtype,
		conf->svr[i].clopt,
        conf->svr[i].ulogdir );

	    n = strlen(data);
	}

	free(conf);
	*buf = data;
	return (strlen(data) + 1);
}

/*
+---------------------------------------------------------------+
|  * Service Info [cfg -s]                                      |
+---------------------------------------------------------------+
*/
int
svcconf(char **buf)
{
	int i, n, size, svccount;
	struct tmadm_svc_conf info;
	struct tmadm_svc_conf *conf;

	memset(&info, 0x00, sizeof(struct tmadm_svc_conf));
	info.header.version = _TMADMIN_VERSION;
	info.header.size = sizeof(struct tmadm_svc_conf);
	n = tmadmin(TMADM_SVC_CONF, &info, 0, 0);
	if (n < 0)
	    return -1;

	svccount = info.header.num_entry + info.header.num_left;
	size = sizeof(struct tmadm_svc_conf) + 
	    (svccount - 1) * sizeof (struct tmadm_svc_conf_body);
	conf = (struct tmadm_svc_conf *) malloc(size);
	if (conf == NULL)
	    return -1;

	memset(conf, 0x00, size);
	conf->header.version = _TMADMIN_VERSION;
	conf->header.size = size;
	n = tmadmin(TMADM_SVC_CONF, conf, 0, 0);
	if (n < 0) {
	    free(conf);
	    return -1;
	}

    data[0] = '\0';

	n = 0;
	for (i = 0; i < svccount; i++) {
	    sprintf(data + n, "%-16s\t%10d\t%10d\t\n",
		conf->svc[i].name,
        conf->svc[i].svctime,
		conf->svc[i].svri);

	    n = strlen(data);
	}

	free(conf);
	*buf = data;
	return (strlen(data) + 1);
}
		
/*
+---------------------------------------------------------------+
|  * Status of Service [st -s]                                  |
+---------------------------------------------------------------+
*/
int
svcstat(char **buf, char *sname)
{
	int i, n, size, svccount;
	struct tmadm_svc_stat info;
	struct tmadm_svc_stat *stat;

	memset(&info, 0x00, sizeof(struct tmadm_svc_stat));
	info.header.version = _TMADMIN_VERSION;
	info.header.size = sizeof(struct tmadm_svc_stat);
	if (sname[0] != 0) {
	    strcpy(info.header.opt_char, sname);
	    n = tmadmin(TMADM_SVC_STAT, &info, TMADM_SFLAG, 0);
	} else {
	    n = tmadmin(TMADM_SVC_STAT, &info, 0, 0);
	}
	if (n < 0) {
	    printf("%s:%d tperrno = %d\n", __FILE__, __LINE__, tperrno);
	    return -1;
	}

	svccount = info.header.num_entry + info.header.num_left;
	size = sizeof(struct tmadm_svc_stat) + 
	    (svccount - 1) * sizeof (struct tmadm_svc_stat_body);
	stat = (struct tmadm_svc_stat *) malloc(size);
	if (stat == NULL) {
	    printf("%s:%d size = %d\n", __FILE__, __LINE__, size);
	    return -1;
	}

	memset(stat, 0x00, size);
	stat->header.version = _TMADMIN_VERSION;
	stat->header.size = size;
	if (sname[0] != 0) {
	    strcpy(stat->header.opt_char, sname);
	    n = tmadmin(TMADM_SVC_STAT, stat, TMADM_SFLAG, 0);
	} else {
	    n = tmadmin(TMADM_SVC_STAT, stat, 0, 0);
	}
	if (n < 0) {
	    printf("%s:%d tperrno = %d\n", __FILE__, __LINE__, tperrno);
	    free(stat);
	    return -1;
	}

    /*
	sprintf(data, 
	    "------------------------------------------------------------------------\n"
	    "clh svci svc_name        count    avg   cq_count  aq_count q_avg    stat\n"
	    "------------------------------------------------------------------------\n");
    */
/*
struct tmadm_svc_stat_body {
        int     no;
        int     clhno;
        int     count;
        int     cq_count;
        int     aq_count;
        int     reserve[3];
        float   average;
        float   q_average;
        char    name[TMAX_NAME_SIZE];
        char    status[TMAX_NAME_SIZE];
        / char reserve_str[TMAX_NAME_SIZE*2]; /
};
*/
    	data[0]='\0';
	n = strlen(data);
	sprintf(data+n, "T["\
			"clhno|"\
			"svc_name|"\
			"count|"\
			"average|"\
			"aq_count|"\
			"cq_count|"\
			"q_average|"\
			"status|"\
			"]T");

	n = strlen(data);
	sprintf(data+n, "D[");

	n = strlen(data);
	svccount = stat->header.num_entry;
	for (i = 0; i < svccount; i++) {
        	sprintf(data + n, "%d|%-s|%d|%.3f|%d|%d|%.3f|%-s|#",
		    stat->svc[i].clhno,
		    stat->svc[i].name,
		    stat->svc[i].count,
		    stat->svc[i].average,
		    stat->svc[i].aq_count,
		    stat->svc[i].cq_count,
		    stat->svc[i].q_average,
		    stat->svc[i].status);
	    	n = strlen(data);
	}
	n = strlen(data);
	sprintf(data+n, "]D");

	free(stat);
	*buf = data;
	return (strlen(data) + 1);
}

/*
+---------------------------------------------------------------+
|  * Status of Server [st -p]                                   |
+---------------------------------------------------------------+
*/
int
sprstat(char **buf, char *sname)
{
	int i, n, size, sprcount;
	struct tmadm_spr_stat info;
	struct tmadm_spr_stat *stat;

	memset(&info, 0x00, sizeof(struct tmadm_spr_stat));
	info.header.version = _TMADMIN_VERSION;
	info.header.size = sizeof(struct tmadm_spr_stat);
	if (sname[0] != 0) {
	    strcpy(info.header.opt_char, sname);
	    n = tmadmin(TMADM_SPR_STAT, &info, TMADM_SFLAG, 0);
	} else {
	    n = tmadmin(TMADM_SPR_STAT, &info, 0, 0);
	}

	if (n < 0) {  return -1; }

	sprcount = info.header.num_entry + info.header.num_left;
	size = sizeof(struct tmadm_spr_stat) + 
	    (sprcount - 1) * sizeof (struct tmadm_spr_stat_body);
	stat = (struct tmadm_spr_stat *) malloc(size);
	if (stat == NULL)
	    return -1;

	memset(stat, 0x00, size);
	stat->header.version = _TMADMIN_VERSION;
	stat->header.size = size;
	if (sname[0] != 0) {
	    strcpy(stat->header.opt_char, sname);
	    n = tmadmin(TMADM_SPR_STAT, stat, TMADM_SFLAG, 0);
	} else {
	    n = tmadmin(TMADM_SPR_STAT, stat, 0, 0);
	}
	if (n < 0) {
	    free(stat);
	    return -1;
	}

    /*
	sprintf(data, 
	    "-----------------------------------------------------------------------\n"
	    "clh svr_name     svgname    spr_no    status     count      avg    svc \n"
	    "-----------------------------------------------------------------------\n");
    */
	/* title make */
	sprintf(data,   "T["\
			"clh|"\
			"svr_name|"\
			"svgname|"\
			"spr_no|"\
			"status|"\
			"count|"\
			"avg|"\
			"svc|"\
			"]T");

	n = strlen(data);
	sprintf(data+n, "D[");
	sprcount = stat->header.num_entry;
	n = strlen(data);
	for (i = 0; i < sprcount; i++) {
		sprintf(data + n, "%d|%-s|%-s|%d|%s|%d|%.3f|%-s|#",
		    stat->spr[i].clhno,
		    stat->spr[i].name,
		    stat->spr[i].svgname,
		    stat->spr[i].no,
		    stat->spr[i].status,
		    stat->spr[i].count,
		    stat->spr[i].average,
		    (stat->spr[i].service[0] ? stat->spr[i].service : "-1"));
		n = strlen(data);
	}
	n = strlen(data);
	sprintf(data+n, "]D");

	free(stat);
	*buf = data;
	return (strlen(data) + 1);
}

/*---------------------------------------------------------------------------*/
/*
+---------------------------------------------------------------+
|  * Status of Server [st -p] C client version                                  |
+---------------------------------------------------------------+
*/
int
sprstatc(char **buf, char *sname)
{
	int i, n, size, sprcount;
	struct tmadm_spr_stat info;
	struct tmadm_spr_stat *stat;

	memset(&info, 0x00, sizeof(struct tmadm_spr_stat));
	info.header.version = _TMADMIN_VERSION;
	info.header.size = sizeof(struct tmadm_spr_stat);
	if (sname[0] != 0) {
	    strcpy(info.header.opt_char, sname);
	    n = tmadmin(TMADM_SPR_STAT, &info, TMADM_SFLAG, 0);
	} else {
	    n = tmadmin(TMADM_SPR_STAT, &info, 0, 0);
	}
/*
	if (n < 0)
    {
	    return -1;
    }
*/
	sprcount = info.header.num_entry + info.header.num_left;
	size = sizeof(struct tmadm_spr_stat) + 
	    (sprcount - 1) * sizeof (struct tmadm_spr_stat_body);
	stat = (struct tmadm_spr_stat *) malloc(size);
	if (stat == NULL)
	    return -1;

	memset(stat, 0x00, size);
	stat->header.version = _TMADMIN_VERSION;
	stat->header.size = size;
	if (sname[0] != 0) {
	    strcpy(stat->header.opt_char, sname);
	    n = tmadmin(TMADM_SPR_STAT, stat, TMADM_SFLAG, 0);
	} else {
	    n = tmadmin(TMADM_SPR_STAT, stat, 0, 0);
	}
	printf("[%d]\n", n);
	/*
	if (n < 0) {
	    free(stat);
	    return -1;
	}
	*/
    
    data[0] = '\0';
	
    sprintf(data, 
	    "-----------------------------------------------------------------------\n"
	    "clh svr_name     svgname    spr_no    status     count      avg    svc \n"
	    "-----------------------------------------------------------------------\n");
    
	n = strlen(data);
	sprcount = stat->header.num_entry;
	for (i = 0; i < sprcount; i++) {
	      sprintf(data + n, " %d  %-12s %-12s  %3d     %5s  %7d     %3.2f     %s\n", 
    /*    sprintf(data + n, "%2d|%-16s|%-16s|%3d|%5s|%7d|%10.2f|%-20s|",*/
		    stat->spr[i].clhno,
		    stat->spr[i].name, 
		    stat->spr[i].svgname,
		    stat->spr[i].no,
		    stat->spr[i].status,
		    stat->spr[i].count,
		    stat->spr[i].average,
		    (stat->spr[i].service[0] ? stat->spr[i].service : "-1"));
	    n = strlen(data);
	}

	free(stat);
	*buf = data;
	return (strlen(data) + 1);
}
/*---------------------------------------------------------------------------*/

/*---------------------------------------------------------------------------*/
/*
+---------------------------------------------------------------+
|  * Status of Service [st -s] C version                        |
+---------------------------------------------------------------+
*/
int
svcstatc(char **buf, char *sname)
{
	int i, n, size, svccount;
	struct tmadm_svc_stat info;
	struct tmadm_svc_stat *stat;

	printf("svcstatc\n");
	
	memset(&info, 0x00, sizeof(struct tmadm_svc_stat));
	info.header.version = _TMADMIN_VERSION;
	info.header.size = sizeof(struct tmadm_svc_stat);
	if (sname[0] != 0) {
	    strcpy(info.header.opt_char, sname);
	    n = tmadmin(TMADM_SVC_STAT, &info, TMADM_SFLAG, 0);
	} else {
	    n = tmadmin(TMADM_SVC_STAT, &info, 0, 0);
	}
	/*
	if (n < 0) {
	    printf("%s:%d tperrno = %d\n", __FILE__, __LINE__, tperrno);
	    return -1;
	}
	*/
	printf("n is [%d]\n", n);
	svccount = info.header.num_entry + info.header.num_left;
	size = sizeof(struct tmadm_svc_stat) + 
	    (svccount - 1) * sizeof (struct tmadm_svc_stat_body);
	stat = (struct tmadm_svc_stat *) malloc(size);
	
	if (stat == NULL) {
	    printf("%s:%d size = %d\n", __FILE__, __LINE__, size);
	    return -1;
	}
	
	memset(stat, 0x00, size);
	stat->header.version = _TMADMIN_VERSION;
	stat->header.size = size;
	
	if (sname[0] != 0) {
	    strcpy(stat->header.opt_char, sname);
	    n = tmadmin(TMADM_SVC_STAT, stat, TMADM_SFLAG, 0);
	} else {
	    n = tmadmin(TMADM_SVC_STAT, stat, 0, 0);
	}
	
	
	/*
	if (n < 0) {
	    printf("%s:%d tperrno = %d\n", __FILE__, __LINE__, tperrno);
	    free(stat);
	    return -1;
	}
	*/
    
    data[0]='\0';
	sprintf(data, 
	    "------------------------------------------------------------------------\n"
	    "clh svci svc_name        count    avg   cq_count  aq_count q_avg    stat\n"
	    "------------------------------------------------------------------------\n");
    
    
    
	n = strlen(data);
	
	svccount = stat->header.num_entry;
	for (i = 0; i < svccount; i++) {
        /*sprintf(data + n, "%2d|%-16s|%6d|%10.2f|%3d|%6d|%5.2f|%10s|",*/
	    sprintf(data + n, " %d  %3d  %-14s %6d   %3.2f        %3d    %6d  %3.2f     %s\n", 
		    stat->svc[i].clhno,
		    stat->svc[i].no, 
		    stat->svc[i].name,
		    stat->svc[i].count,
		    stat->svc[i].average,
		    stat->svc[i].aq_count,
		    stat->svc[i].cq_count,
		    stat->svc[i].q_average,
		    stat->svc[i].status);
	    n = strlen(data);
	}
	
		
	free(stat);
	*buf = data;
	return (strlen(data) + 1);
}
/*---------------------------------------------------------------------------*/


/*
+---------------------------------------------------------------+
|  * Status of SvrInfo [si]                                     |
+---------------------------------------------------------------+
*/
int
svrstat(char **buf, char *sname)
{
	int i, n, size, svrcount;
	struct tmadm_svr_stat info;
	struct tmadm_svr_stat *stat;

	memset(&info, 0x00, sizeof(struct tmadm_svr_stat));
	info.header.version = _TMADMIN_VERSION;
	info.header.size = sizeof(struct tmadm_svr_stat);
	if (sname[0] != 0) {
	    strcpy(info.header.opt_char, sname);
	    n = tmadmin(TMADM_SVR_STAT, &info, TMADM_SFLAG, 0);
	} else {
	    n = tmadmin(TMADM_SVR_STAT, &info, 0, 0);
	}
	if (n < 0)
	    return -1;

	svrcount = info.header.num_entry + info.header.num_left;
	size = sizeof(struct tmadm_svr_stat) + 
	    (svrcount - 1) * sizeof (struct tmadm_svr_stat_body);
	stat = (struct tmadm_svr_stat *) malloc(size);
	if (stat == NULL)
	    return -1;

	memset(stat, 0x00, size);
	stat->header.version = _TMADMIN_VERSION;
	stat->header.size = size;
	if (sname[0] != 0) {
	    strcpy(stat->header.opt_char, sname);
	    n = tmadmin(TMADM_SVR_STAT, stat, TMADM_SFLAG, 0);
	} else {
	    n = tmadmin(TMADM_SVR_STAT, stat, 0, 0);
	}
	if (n < 0) {
	    free(stat);
	    return -1;
	}

    /*
	sprintf(data, 
	    "------------------------------------------------------------------------\n"
	    "  clh   svrname    (svri)   status     count   qcount   qpcount  emcount\n"
	    "------------------------------------------------------------------------\n");
    */

    	data[0]='\0';
	n = strlen(data);
	sprintf(data+n, "T["\
			"clhno|"\
			"svrname|"\
			"(svri)|"\
			"status|"\
			"count|"\
			"qcount|"\
			"qpcount|"\
			"emcount|"\
			"]T");

	n = strlen(data);
	sprintf(data+n, "D[");


	n = strlen(data);
	svrcount = stat->header.num_entry;
	for (i = 0; i < svrcount; i++) {
	    sprintf(data + n, "%d|%s|%d|%-s|%d|%d|%d|%d|#",
		    stat->svr[i].clhno,
		    stat->svr[i].name,
		    stat->svr[i].svri,
		    stat->svr[i].status,
		    stat->svr[i].count,
		    stat->svr[i].qcount,
		    stat->svr[i].qpcount,
		    stat->svr[i].emcount);
	    n = strlen(data);
	}
	n = strlen(data);
	sprintf(data+n, "]D");

	free(stat);
	*buf = data;
	return (strlen(data) + 1);
}

/*
+---------------------------------------------------------------+
|  * Client of Info [ci]                                        |
+---------------------------------------------------------------+
*/
int
cliinfo(char **buf, char *sname)
{
	int i, n, size, clicount;
	struct tmadm_cliinfo info;
	struct tmadm_cliinfo *stat;

	memset(&info, 0x00, sizeof(struct tmadm_cliinfo));
	info.header.version = _TMADMIN_VERSION;
	info.header.size = sizeof(struct tmadm_cliinfo);
	if (sname[0] != 0) {
	    n = tmadmin(TMADM_CLIINFO, &info, TMADM_SFLAG, 0);
	} else {
	    n = tmadmin(TMADM_CLIINFO, &info, 0, 0);
	}
	if (n < 0)
	    return -1;

	clicount = info.header.num_entry + info.header.num_left;
	/*if (sname[0] != 0) {
	    sprintf(data, "Total Connected Clients = %d \n", clicount);
	    *buf = data;
	    return (strlen(data) + 1);
	}*/

	if (sname[0] != 0) {
	    sprintf(data, "%d", clicount);
	    *buf = data;
	    return (strlen(data) + 1);
	}

	/* clicount can vary widely */
	size = sizeof(struct tmadm_cliinfo) + 
	    (clicount * 2) * sizeof (struct tmadm_cliinfo_body);
	stat = (struct tmadm_cliinfo *) malloc(size);
	if (stat == NULL)
	    return -1;

	memset(stat, 0x00, size);
	stat->header.version = _TMADMIN_VERSION;
	stat->header.size = size;
	n = tmadmin(TMADM_CLIINFO, stat, 0, 0);
	if (n < 0) {
	    free(stat);
	    return -1;
	}

	/*sprintf(data, 
	    "------------------------------------------------------------------------\n"
	    "clhno   cli(CLID)    status    count   idle_time   ipaddr      usrname\n"
	    "------------------------------------------------------------------------\n");*/
    data[0]='\0';
	n = strlen(data);
	clicount = stat->header.num_entry;
	/*for (i = 0; i < clicount; i++) {
	    sprintf(data + n, "%3d %4d(0x%08x) %5s    %6d    %5d %15s   %s\n",
		    stat->cli[i].clhno,
		    stat->cli[i].no,
		    stat->cli[i].clid,
		    stat->cli[i].status,
		    stat->cli[i].count,
		    stat->cli[i].idle,
		    stat->cli[i].addr,
		    stat->cli[i].usrname);
	    n = strlen(data);
	}*/

	for (i = 0; i < clicount; i++) {
	    sprintf(data + n, "%3d\t%4d\t0x%08x\t%5s\t%6d\t%5d\t%15s\t\n",
		    stat->cli[i].clhno,
		    stat->cli[i].no,
		    stat->cli[i].clid,
		    stat->cli[i].status,
		    stat->cli[i].count,
		    stat->cli[i].idle,
		    stat->cli[i].addr);
	    n = strlen(data);
	}
	free(stat);
	*buf = data;
	return (strlen(data) + 1);
}


/*
+---------------------------------------------------------------+
|  * Queue of Purge [qp]                                        |
+---------------------------------------------------------------+
*/
int
qpurge(char **buf, char *sname)
{
	int n;

	if (sname[0] == 0)
	    return -1;

	/* In this example, only service queue is purged.
	   If you want to purge server queue, user TMADM_VFLAG */
	n = tmadmin(TMADM_QPURGE, sname, TMADM_SFLAG, 0);
	if (n < 0) {
	    sprintf(data, "No such service (%s) is found\n", sname);
	    *buf = data;
	    return (strlen(data) + 1);
	}

	sprintf(data, 
	    "Queue for svc %s is purged: purged_count = %d \n", sname, n);
	*buf = data;
	return (strlen(data) + 1);
}


/*
+---------------------------------------------------------------+
|  * Queue of Clear [restat -v]                                 |
+---------------------------------------------------------------+
*/
int
restat(char **buf, char *sname)
{
	int n;
	long flag;

	if (sname[0] == 0)
	    flag = TMADM_AFLAG;
	else
	    flag = TMADM_VFLAG;

	n = tmadmin(TMADM_RESTAT, sname, flag, 0);
	if (n < 0) {
	    if (flag == TMADM_SFLAG) {
	        sprintf(data, "No such server (%s) is found\n", sname);
	        *buf = data;
	        return (strlen(data) + 1);
	    }
	    return -1;
	}

	if (flag == TMADM_VFLAG)
	    sprintf(data, "Server(%s) statistics cleared\n", sname);
	else
	    sprintf(data, "Statistics cleared\n");
	*buf = data;
	return (strlen(data) + 1);
}


int
boot(char **buf, char *sname)
{
	int n;
	struct tmadm_boot info;

	if (sname[0] == 0)
	    return -1;

	memset((char*)&info, 0x00, sizeof(struct tmadm_boot));
	info.header.version = _TMADMIN_VERSION;
	info.header.size = sizeof(struct tmadm_boot);
	strncpy(info.args.name1, sname, TMAX_NAME_SIZE);
	info.args.count = 1;

	n = tmadmin(TMADM_BOOT, &info, TMADM_SFLAG, 0);
	if (n < 0) {
	    return -1;
	}

	sprintf(data, "Server(%s) is booted\n", sname);
	*buf = data;
	return (strlen(data) + 1);
}


int
down(char **buf, char *sname)
{
	int n;
	struct tmadm_down info;

	if (sname[0] == 0)
	    return -1;

	memset((char*)&info, 0x00, sizeof(struct tmadm_down));
	info.header.version = _TMADMIN_VERSION;
	info.header.size = sizeof(struct tmadm_down);
	strncpy(info.args.name1, sname, TMAX_NAME_SIZE);
	info.args.count = 1;

	n = tmadmin(TMADM_DOWN, &info, TMADM_SFLAG, 0);
	if (n < 0) {
	    return -1;
	}

	sprintf(data, "Server(%s) is down\n", sname);
	*buf = data; return (strlen(data) + 1); 
}

#define TMADM_SVR_SUSPEND	66
#define TMADM_SVC_SUSPEND	67
#define TMADM_SVR_RESUME	77
#define TMADM_SVC_RESUME	78
/*
#define TMADM_SVC_STAT          11
#define TMADM_SPR_STAT          12
#define TMADM_SVR_STAT          13
*/
TMAXADMIN(TPSVCINFO *msg)
{
	char cmd, *buf, *sndbuf;
	int len;
	long sndlen;
	char sname[20+1];
	char *temp_ptr = NULL;
	char temp[50];
	char admin_cmd[256];

	struct sockaddr_in cli;
	char ipAddr[16];
	int cli_len, ret;
	
	struct tmaxadmin_cmd {
		char	cmd[2];
		char	sname[20]; /* argument *, server, service */
		int	confirm_code;
	} tmadm_cmd;
	

	memset((char *)&cli, 0, sizeof(cli));
	ret = tpgetpeer_ipaddr((struct sockaddr *)&cli, &cli_len);
	if (ret == -1) {
		printf("tpgetpeer_ipaddr Error..!!\n");
		tpreturn(TPFAIL, 0, NULL, 0, 0); 
	}
	else{
		memcpy(ipAddr, inet_ntoa(cli.sin_addr), 16);
	}
printf("ip = %s , port = %d\n", ipAddr, cli.sin_port);

	if (msg->len < 1)
	{
		printf("Request's Length less than 1\n");
		tpreturn(TPFAIL, 0, NULL, 0, 0); 
	}
	memset(&tmadm_cmd,0x00,sizeof(tmadm_cmd));
	memcpy(&tmadm_cmd,msg->data,sizeof(tmadm_cmd));
printf("CMD =[%-2s], sname = [%-20s] confirm_code[%d]\n", tmadm_cmd.cmd, tmadm_cmd.sname, tmadm_cmd.confirm_code);

	memset(temp,0x00,sizeof(temp));
	memcpy(temp,tmadm_cmd.cmd,sizeof(tmadm_cmd.cmd));
	cmd = atoi(temp);
printf("CMD = [%d]\n", cmd, sname);

	memset(sname,0x00,sizeof(sname));
        temp_ptr = strchr(tmadm_cmd.sname, ' ');
        *temp_ptr = '\0';
	memcpy(sname,tmadm_cmd.sname,sizeof(tmadm_cmd.sname));

printf("CMD = [%d], sname = [%s]\n", cmd, sname);

	switch (cmd) {
	    case TMADM_TMAX_INFO:
			len = tmaxinfo(&buf);
			break;
	    case TMADM_DOMAIN_CONF:
			len = domainconf(&buf);
			break;
	    case TMADM_NODE_CONF:
			len = nodeconf(&buf);
			break;
	    case TMADM_SVG_CONF:
			len = svgconf(&buf);
			break;
	    case TMADM_SVR_CONF:
			len = svrconf(&buf);
			break;
	    case TMADM_SVC_CONF:
			len = svcconf(&buf);
			break;
	    case TMADM_SVC_STAT:
			len = svcstat(&buf, sname);
			break;
/*
	    case TMADM_SVC_STATC:
			len = svcstatc(&buf, sname);
			break; 
*/
	    case TMADM_SPR_STAT:
printf("sprstat start...~~~\n");
			len = sprstat(&buf, sname);
			break;
/*
	    case TMADM_SPR_STATC:
			len = sprstatc(&buf, sname);
			break;
*/
	    case TMADM_SVR_STAT:
			len = svrstat(&buf, sname);
			break;
	    case TMADM_CLIINFO:
			len = cliinfo(&buf, sname);
			break;
	    case TMADM_QPURGE:
			len = qpurge(&buf, sname);
			break;
	    case TMADM_RESTAT:
			len = restat(&buf, sname);
			break;
	    case TMADM_BOOT:
			len = boot(&buf, sname);
			break;
	    case TMADM_DOWN:
			len = down(&buf, sname);
			break;
	    case TMADM_DISCON:
			sprintf(admin_cmd, "/wjc/bin/admin_cmd.sh 'ds -c %s -f'", sname);
			system(admin_cmd);

			sprintf(admin_cmd, "Client %s Disconnted.", sname);
			buf = (char *) admin_cmd;
			len = strlen(buf);
			break;
	    case TMADM_SVR_SUSPEND:
			sprintf(admin_cmd, "/wjc/bin/admin_cmd.sh 'sp -v %s'", sname);
			system(admin_cmd);

			sprintf(admin_cmd, "Server %s Suspended.", sname);
			buf = (char *) admin_cmd;
			len = strlen(buf);
			break;
	    case TMADM_SVR_RESUME:
			sprintf(admin_cmd, "/wjc/bin/admin_cmd.sh 'rs -v %s'", sname);
			system(admin_cmd);

			sprintf(admin_cmd, "Server %s Resumed.", sname);
			buf = (char *) admin_cmd;
			len = strlen(buf);
			break;
	    case TMADM_SVC_SUSPEND:
			sprintf(admin_cmd, "/wjc/bin/admin_cmd.sh 'sp -s %s'", sname);
			system(admin_cmd);

			sprintf(admin_cmd, "Service %s Suspended.", sname);
			buf = (char *) admin_cmd;
			len = strlen(buf);
			break;
	    case TMADM_SVC_RESUME:
			sprintf(admin_cmd, "/wjc/bin/admin_cmd.sh 'rs -s %s'", sname);
			system(admin_cmd);

			sprintf(admin_cmd, "Service %s Resumed.", sname);
			buf = (char *) admin_cmd;
			len = strlen(buf);
			break;
	    default:
		len = -1;
		break;
	}

	if (len < 0) {
	    printf("[ADMIN Argument is invalid\n");
	    tpreturn(TPFAIL, 0, NULL, 0, 0); 
	}

	if ((sndbuf = (char *)tpalloc("STRING", NULL, len + 1)) == NULL)
	    tpreturn(TPFAIL, 0, NULL, 0, 0); 

	memcpy(sndbuf, buf, len);
	sndlen = len;
	/* do not free it's static area 
	free(buf);
	*/

	tpreturn(TPSUCCESS, 0, sndbuf, sndlen, 0); 
}

