CREATE OR REPLACE PACKAGE BODY vcr.pkg_notifications AS
  ------------------------------------------------------------------------
  -- $Header: vcr/packages/pkg_notifications.plb 1.5.1.7 2005/10/10 14:52:43BST ghoekstra DEV  $
  ------------------------------------------------------------------------
  --  A package to send notifications to different types of recipients
  ------------------------------------------------------------------------

  gc_admin_email_cfg_key       CONSTANT VARCHAR2(50) := 'vcr.notification.admin_email';
  gc_support_email_cfg_key     CONSTANT VARCHAR2(50) := 'vcr.notification.support_email';
  gc_notify_admin_yn_cfg_key   CONSTANT VARCHAR2(50) := 'vcr.notification.notify_admin_yn';
  gc_notify_support_yn_cfg_key CONSTANT VARCHAR2(50) := 'vcr.notification.notify_support_yn';

  gc_std_footer_cfg_key CONSTANT VARCHAR2(50) := 'vcr.notification.std_footer';

  PROCEDURE log_notification(p_text        IN VARCHAR2,
                             p_recipients  IN VARCHAR2,
                             p_subject     IN VARCHAR2,
                             p_body        IN VARCHAR2,
                             p_load_run_id IN source_load_run.load_run_id%TYPE DEFAULT NULL) AS
    v_log_parent_table VARCHAR2(100);
  BEGIN
    dbms_application_info.set_module('vcr.pkg_notifications.log_notification',null);

    IF p_load_run_id IS NULL
    THEN
      v_log_parent_table := NULL;
    ELSE
      v_log_parent_table := pkg_source_load_run.gc_log_message_parent_table;
    END IF;
  
    utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                       substr(p_text || utl.pkg_constants.gc_cr ||
                            'Recipients: ' || utl.pkg_constants.gc_cr ||
                            p_recipients || utl.pkg_constants.gc_cr ||
                            'Subject:' || utl.pkg_constants.gc_cr ||
                            p_subject || utl.pkg_constants.gc_cr ||
                            'Message:' || utl.pkg_constants.gc_cr || p_body,
                            1,
                            4000),
                       v_log_parent_table,
                       p_load_run_id);

    dbms_application_info.set_module(null,null);
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END log_notification;

  PROCEDURE notify_by_email(p_type            IN VARCHAR2,
                            p_recipients      IN VARCHAR2,
                            p_subject         IN VARCHAR2,
                            p_body            IN VARCHAR2,
                            p_attachment_name IN VARCHAR2 DEFAULT NULL,
                            p_attachment      IN CLOB DEFAULT NULL,
                            p_load_run_id     IN source_load_run.load_run_id%TYPE DEFAULT NULL,
                            p_attachment2_name IN VARCHAR2 DEFAULT NULL,
                            p_attachment2      IN CLOB DEFAULT NULL,
                            p_sender           IN VARCHAR2 DEFAULT NULL) AS
  BEGIN
    dbms_application_info.set_module('vcr.pkg_notifications.notify_by_email',null);

    utl.pkg_emailer.send(p_sender,
                         p_recipients,
                         p_subject,
                         p_body,
                         p_attachment_name,
                         p_attachment,
                         p_attachment2_name,
                         p_attachment2);
  
    log_notification(p_type,
                     p_recipients,
                     p_subject,
                     p_body,
                     p_load_run_id);
    
    dbms_application_info.set_module(null,null);
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END notify_by_email;

  -- sends an email message to the defined admin email addresses
  PROCEDURE notify_admin(p_subject         IN VARCHAR2,
                         p_body            IN VARCHAR2,
                         p_attachment_name IN VARCHAR2 DEFAULT NULL,
                         p_attachment      IN CLOB DEFAULT NULL,
                         p_load_run_id     IN source_load_run.load_run_id%TYPE DEFAULT NULL,
                         p_attachment2_name IN VARCHAR2 DEFAULT NULL,
                         p_attachment2      IN CLOB DEFAULT NULL) AS
    v_recipients VARCHAR2(500);
  BEGIN
    dbms_application_info.set_module('vcr.pkg_notifications.notify_admin',null);

    IF upper(utl.pkg_config.get_variable_string(gc_notify_admin_yn_cfg_key)) = 'Y'
    THEN
      v_recipients := utl.pkg_config.get_variable_string(gc_admin_email_cfg_key);
    
      IF v_recipients IS NULL
      THEN
        RAISE utl.pkg_exceptions.e_no_admin_email;
      END IF;
    
      notify_by_email('Admin Notification',
                      v_recipients,
                      p_subject,
                      p_body || utl.pkg_constants.gc_cr || utl.pkg_constants.gc_cr ||
                      utl.pkg_config.get_variable_string(gc_std_footer_cfg_key),
                      p_attachment_name,
                      p_attachment,
                      p_load_run_id,
                      p_attachment2_name,
                      p_attachment2);
    ELSE
      utl.pkg_logger.log(utl.pkg_logger.gc_log_message_info,
                         'Admin Notification ' || p_subject ||
                         ' not sent. Admin notifications are turned off.',
                         pkg_source_load_run.gc_log_message_parent_table,
                         p_load_run_id);
    END IF;
    
    dbms_application_info.set_module(null,null);
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END notify_admin;

  -- sends an email to defined support email addresses
  PROCEDURE notify_support(p_subject         IN VARCHAR2,
                           p_body            IN VARCHAR2,
                           p_attachment_name IN VARCHAR2 DEFAULT NULL,
                           p_attachment      IN CLOB DEFAULT NULL,
                           p_load_run_id     IN source_load_run.load_run_id%TYPE DEFAULT NULL,
                           p_attachment2_name IN VARCHAR2 DEFAULT NULL,
                           p_attachment2      IN CLOB DEFAULT NULL) AS
    v_recipients VARCHAR2(500);
  BEGIN
    dbms_application_info.set_module('vcr.pkg_notifications.notify_support',null);
    
    IF upper(utl.pkg_config.get_variable_string(gc_notify_support_yn_cfg_key)) = 'Y'
    THEN
      v_recipients := utl.pkg_config.get_variable_string(gc_support_email_cfg_key);
    
      IF v_recipients IS NULL
      THEN
        RAISE utl.pkg_exceptions.e_no_support_email;
      END IF;
    
      notify_by_email('Support Notification',
                      v_recipients,
                      p_subject,
                      p_body || utl.pkg_constants.gc_cr || utl.pkg_constants.gc_cr ||
                      utl.pkg_config.get_variable_string(gc_std_footer_cfg_key),
                      p_attachment_name,
                      p_attachment,
                      p_load_run_id,
                      p_attachment2_name,
                      p_attachment2);
    ELSE
      utl.pkg_logger.log(utl.pkg_logger.gc_log_message_info,
                         'Support Notification ' || p_subject ||
                         ' not sent. Support notifications are turned off.',
                         pkg_source_load_run.gc_log_message_parent_table,
                         p_load_run_id);
    END IF;
    
    dbms_application_info.set_module(null,null);
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END notify_support;

  -- sends an email message to the defined admin and support email addresses
  PROCEDURE notify_admin_and_support(p_subject         IN VARCHAR2,
                                     p_body            IN VARCHAR2,
                                     p_attachment_name IN VARCHAR2 DEFAULT NULL,
                                     p_attachment      IN CLOB DEFAULT NULL,
                                     p_load_run_id     IN source_load_run.load_run_id%TYPE DEFAULT NULL,
                                     p_attachment2_name IN VARCHAR2 DEFAULT NULL,
                                     p_attachment2      IN CLOB DEFAULT NULL) AS
  BEGIN
    dbms_application_info.set_module('vcr.pkg_notifications.notify_admin_and_support',null);
    
    notify_admin(p_subject,
                 p_body,
                 p_attachment_name,
                 p_attachment,
                 p_load_run_id,
                 p_attachment2_name,
                 p_attachment2);
                 
    notify_support(p_subject,
                   p_body,
                   p_attachment_name,
                   p_attachment,
                   p_load_run_id,
                   p_attachment2_name,
                   p_attachment2);
    
    dbms_application_info.set_module(null,null);
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END notify_admin_and_support;

  -- sends an email to the defined investment_engine
  PROCEDURE notify_ie(p_ie_id           IN investment_engine.ie_id%TYPE,
                      p_subject         IN VARCHAR2,
                      p_body            IN VARCHAR2,
                      p_attachment_name IN VARCHAR2 DEFAULT NULL,
                      p_attachment      IN CLOB DEFAULT NULL,
                      p_load_run_id     IN source_load_run.load_run_id%TYPE DEFAULT NULL,
                      p_attachment2_name IN VARCHAR2 DEFAULT NULL,
                      p_attachment2      IN CLOB DEFAULT NULL) AS
  BEGIN
    dbms_application_info.set_module('vcr.pkg_notifications.notify_ie',null);
    
    FOR rec_ie IN (SELECT email_address
                   FROM   investment_engine
                   WHERE  ie_id LIKE p_ie_id)
    LOOP
      IF rec_ie.email_address IS NULL
      THEN
        RAISE utl.pkg_exceptions.e_no_ie_email;
      END IF;
    
      notify_by_email('IE Notification',
                      rec_ie.email_address,
                      p_subject,
                      p_body || utl.pkg_constants.gc_cr || utl.pkg_constants.gc_cr ||
                      utl.pkg_config.get_variable_string(gc_std_footer_cfg_key),
                      p_attachment_name,
                      p_attachment,
                      p_load_run_id,
                      p_attachment2_name,
                      p_attachment2);
    END LOOP;
    
    dbms_application_info.set_module(null,null);
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END notify_ie;

  -- sends an email to the defined investment_engine
  PROCEDURE notify_ie_platform(p_ie_id           IN investment_engine.ie_id%TYPE,
                               p_ie_platform     IN ie_platform.ie_platform%TYPE,
                               p_subject         IN VARCHAR2,
                               p_body            IN VARCHAR2,
                               p_attachment_name IN VARCHAR2 DEFAULT NULL,
                               p_attachment      IN CLOB DEFAULT NULL,
                               p_load_run_id     IN source_load_run.load_run_id%TYPE DEFAULT NULL,
                               p_attachment2_name IN VARCHAR2 DEFAULT NULL,
                               p_attachment2      IN CLOB DEFAULT NULL) AS
    v_recipients VARCHAR2(500);
  BEGIN
    dbms_application_info.set_module('vcr.pkg_notifications.notify_ie_platform',null);
    
    SELECT email_address
    INTO   v_recipients
    FROM   ie_platform
    WHERE  ie_id = p_ie_id
    AND    ie_platform = p_ie_platform;
  
    IF v_recipients IS NULL
    THEN
      RAISE utl.pkg_exceptions.e_no_ie_platform_email;
    END IF;
  
    notify_by_email('IE Platform Notification',
                    v_recipients,
                    p_subject,
                    p_body || utl.pkg_constants.gc_cr || utl.pkg_constants.gc_cr ||
                    utl.pkg_config.get_variable_string(gc_std_footer_cfg_key),
                    p_attachment_name,
                    p_attachment,
                    p_load_run_id,
                    p_attachment2_name,
                    p_attachment2);
    
    dbms_application_info.set_module(null,null);
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END notify_ie_platform;

  -- sends secure message to source
  PROCEDURE notify_source(p_source_id       IN source.source_id%TYPE,
                          p_subject         IN VARCHAR2,
                          p_body            IN VARCHAR2,
                          p_attachment_name IN VARCHAR2 DEFAULT NULL,
                          p_attachment      IN CLOB DEFAULT NULL,
                          p_load_run_id     IN source_load_run.load_run_id%TYPE DEFAULT NULL,
                          p_attachment2_name IN VARCHAR2 DEFAULT NULL,
                          p_attachment2      IN CLOB DEFAULT NULL) AS
    v_recipients VARCHAR2(500);
  BEGIN
    dbms_application_info.set_module('vcr.pkg_notifications.notify_source',null);
    
    SELECT email_address
    INTO   v_recipients
    FROM   source
    WHERE  source_id = p_source_id;
  
    IF v_recipients IS NULL
    THEN
      RAISE utl.pkg_exceptions.e_no_source_email;
    END IF;
  
    notify_by_email('Source Notification',
                    v_recipients,
                    p_subject,
                    p_body,
                    p_attachment_name,
                    p_attachment,
                    p_load_run_id,
                    p_attachment2_name,
                    p_attachment2,
                    'Man Investments');
                    
    dbms_application_info.set_module(null,null);
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END notify_source;

  -- Executes the shell command that sends a secure message over the moveit infrastructure
  -- Test script:
  -- $ touch /app/vcrdev/tmp/Fairytale
  -- $ java -cp ../lib/MOVEitAPI.jar:../lib securesend \
  -- --moveituser vcr --moveitpass a1s2d3f4 --moveithost midatx.com \
  -- --proxyhost  192.5.13.196 --proxyport  8080  \
  -- --proxyuser  moveitadmin --proxypass "A1s2d3f4" --recipient "test" --subject "Fairytale" \
  -- --message   "A long time ago. " --attachment "/app/vcrdev/tmp/Fairytale" -d
  procedure notify_source_securely(
    p_source_id       IN source.source_id%TYPE,
    p_subject         IN VARCHAR2,
    p_body            IN VARCHAR2,
    p_attachment_name IN VARCHAR2 DEFAULT NULL, -- Try to use this as the file name for the attachment
    p_attachment      IN CLOB DEFAULT NULL,
    p_load_run_id     IN source_load_run.load_run_id%TYPE DEFAULT NULL)
  is
    c_proc_name         constant varchar2(100)  := pc_schema||'.'||pc_package||'.notify_source_securely';
    v_shell_command     varchar2(1000);    
    v_recipient         source.secure_message_id%type;
    v_vcr_home          utl.config.string_value%type:=utl.pkg_config.get_variable_string('$VCR_HOME');
    v_java_home         utl.config.string_value%type:=utl.pkg_config.get_variable_string('$JAVA_HOME');
    v_log_file_name     utl.config.string_value%type:=utl.pkg_config.get_variable_string('LogFileName');
    v_retcode           pls_integer;
    v_attachment        clob;
    v_attachment_file   varchar2(250);
    v_message           varchar2(32767);
    v_subject           varchar2(250);
    
    -- Get config values
    v_vcr_moveit_user   varchar2(30):=utl.pkg_config.get_variable_string('vcr.moveit.user');
    v_vcr_moveit_pass   varchar2(30):=utl.pkg_config.get_variable_string('vcr.moveit.pass');
    v_vcr_moveit_host   varchar2(30):=utl.pkg_config.get_variable_string('vcr.moveit.host');
    v_vcr_proxy_host    varchar2(30):=utl.pkg_config.get_variable_string('vcr.proxy.host');
    v_vcr_proxy_port    pls_integer :=utl.pkg_config.get_variable_int(   'vcr.proxy.port');
    v_vcr_proxy_user    varchar2(30):=utl.pkg_config.get_variable_string('vcr.proxy.user');
    v_vcr_proxy_pass    varchar2(30):=utl.pkg_config.get_variable_string('vcr.proxy.pass');        
  begin     
    dbms_application_info.set_module(c_proc_name,null);                 
   
    -- Clean up subject
    v_subject:=substr(utl.pkg_string.string2html(p_subject),1,250);
    
    -- Get recipient name
    begin
      select s.secure_message_id
        into v_recipient
        from source s
       where s.source_id = p_source_id;
    exception
      when others then    
        raise utl.pkg_exceptions.e_no_source_email;
    end;        
    if(v_recipient is null)then
      raise utl.pkg_exceptions.e_no_source_email;
    end if;
   
     
    if(p_attachment_name is null)then      
      -- make up artificial file name
      select 'attachment'||sq_attachment_id.nextval
        into v_attachment_file
        from dual;
    else
      -- Try use the given attachment name for the file
      -- but first check if file already exists
      declare
        f utl_file.file_type;
      begin
        f:=utl_file.fopen('VCRTMP',p_attachment_name,'r');
        utl_file.fclose(f);
        -- File already exists - make up artificial file name
        select 'attachment'||sq_attachment_id.nextval
          into v_attachment_file
          from dual;        
      exception
        when others then
          -- File does not exist or a attachment name was specified that could not be
          -- used for a file name, so we use the name of the attachment
          v_attachment_file:=replace(replace(replace(p_attachment_name,
                              '$','_'),
                              '#','_'),
                              ' ','_');
      end;
    end if;
    
    -- We *Have to add an attachment* otherwise message sending fails.
    if(p_attachment is null)then      
      -- Create a dummy attachment and write the message body content to it
      declare
        f utl_file.file_type;
        l_msg dbms_sql.varchar2s:=utl.pkg_string.string2list(p_body);
      begin
        f:=utl_file.fopen('VCRTMP',v_attachment_file,'w');
        for i in l_msg.first..l_msg.last loop
          utl_file.put_line(f,l_msg(i));
        end loop;
        utl_file.fflush(f);
        utl_file.fclose(f);
      exception
        when others then 
          utl_file.fclose(f);
      end;
    else
      -- Write attachment to file
      utl.pkg_file.clob2file('VCRTMP',v_attachment_file,p_attachment);
    end if;      

    -- Make message HTML compatible
    v_message:=utl.pkg_string.string2html(p_body);
    
    -- Makeup shell command
    -- The Java class securesend.class is in the $VCR_HOME/lib
    v_shell_command :=
        'JAVA_HOME='||v_java_home||' '
      ||'VCR_HOME='||v_vcr_home||' '
      ||v_vcr_home||'/bin/moveit.message '
      ||' --moveituser '||v_vcr_moveit_user
      ||' --moveitpass '||v_vcr_moveit_pass
      ||' --moveithost '||v_vcr_moveit_host
      ||' --proxyhost  '||v_vcr_proxy_host
      ||' --proxyport  '||v_vcr_proxy_port
      ||' --proxyuser  '||v_vcr_proxy_user
      ||' --proxypass "'||v_vcr_proxy_pass||'"'
      ||' --recipient "'||v_recipient||'"'
      ||' --subject   "'||v_subject||'"'
      ||' --message   "'||v_message||'"'
      ||' --attachment '||v_attachment_path||'/'||v_attachment_file
      ||' -d '      
      ||' >> '||v_log_path||'/'||v_log_file_name||' 2>&1';

    utl.pkg_logger.log_debug(v_shell_command);
    v_retcode := utl.hostcmd(v_shell_command); 
    if (v_retcode != utl.pkg_exceptions.gc_success)then
      raise_application_error(utl.pkg_exceptions.gc_host_command_err, v_shell_command || ' failed with return code ' || v_retcode);   
    end if;
    
    utl_file.fremove(c_tmp_dir_obj,v_attachment_file);   
    log_notification('Secure Notification',v_recipient,p_subject,p_body,p_load_run_id);
    dbms_application_info.set_module(null,null);                 
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle; 
      begin   
        utl_file.fremove(c_tmp_dir_obj,v_attachment_file);
      exception
        when others then
          null;
      end;
      raise;
  end notify_source_securely; 

begin
  -- Get real attachement path
  begin      
    select directory_path 
      into v_attachment_path
      from sys.all_directories 
     where directory_name=c_tmp_dir_obj;
  exception
    when others then
      utl.pkg_errorhandler.handle;
      raise;
  end;

  -- Get real log path
  begin      
    select directory_path 
      into v_log_path
      from sys.all_directories 
     where directory_name=c_log_dir_obj;
  exception
    when others then
      utl.pkg_errorhandler.handle;
      raise;
  end;
END pkg_notifications;
/
