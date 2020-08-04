function answer = yn_dialog(ques)
opts.Interpreter = 'tex'; opts.Default = 'No';
answer = questdlg(ques,'Dialog Window',...
    'Yes','No',opts);
end