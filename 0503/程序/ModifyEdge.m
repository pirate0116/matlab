%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% code by zhangfeng 2010-5-20                                             %
%                                                                         %
% function: 此程序用于消除人耳采样后边缘点模糊下沉的问题                     %
%                                                                         %
% 准备调节后6行                                                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ZT] = ModifyEdge( ZT )
%% 每线+每块
Interval = 496+32;

%% 线调整


% for i = 0:10 %前8条线进行倒五行的线调整
%     if ZT(27+i*Interval) < ZT(26+i*Interval)
%        ZT(27+i*Interval) = ZT(26+i*Interval);
%     end
%     if ZT(28+i*Interval) < ZT(27+i*Interval)
%        ZT(28+i*Interval) = ZT(27+i*Interval);
%     end
%     if ZT(29+i*Interval) < ZT(28+i*Interval)
%        ZT(29+i*Interval) = ZT(28+i*Interval);
%     end
% end

pre_num = 10589-31-31-31-31-33;%调整外延3的最后一行，即8'线,这里pre_num是10432
for i = 504:-1:499
    if ZT(i + pre_num) < ZT(i + pre_num+1)%调整倒数斜1
        ZT(i + pre_num) = ZT(i + pre_num+1);
    end
end
for i = 473:-1:469
    if ZT(i + pre_num) < ZT(i + pre_num+1) %调整倒数斜2
        ZT(i + pre_num) = ZT(i + pre_num+1);
    end
end


for i = 0:16  %线调整
    if ZT(28+i*Interval) < ZT(27+i*Interval)
        ZT(28+i*Interval) = ZT(27+i*Interval);
    end
    if ZT(29+i*Interval) < ZT(28+i*Interval)
        ZT(29+i*Interval) = ZT(28+i*Interval);
    end
    if ZT(30+i*Interval) < ZT(29+i*Interval)
        ZT(30+i*Interval) = ZT(29+i*Interval);
    end
    if ZT(31+i*Interval) < ZT(30+i*Interval)
        ZT(31+i*Interval) = ZT(30+i*Interval);
    end
    if ZT(32+i*Interval) < ZT(31+i*Interval)
        ZT(32+i*Interval) = ZT(31+i*Interval);
    end
    if ZT(33+i*Interval) < ZT(32+i*Interval)
        ZT(33+i*Interval) = ZT(32+i*Interval);
    end
end

%% 块调整

% for i = 9:-1:0 %前10块的块调整调倒数7行
%     %---------------------------------------------------------------------
%     for j = (358-2):-1:334 % 倒数第7行的前25-2个值挨个跟其在倒数第8行的值及其下一个值的最大值比较
%         if ZT(j+i*Interval) < max(ZT(((j-24)+i*Interval):((j-24+1)+i*Interval)))
%             ZT(j+i*Interval) = max(ZT(((j-24)+i*Interval):((j-24+1)+i*Interval)));
%         end
%     end
%     j = 357; %:358 % 倒数第7行的倒数第二个值
% %     aa = max(ZT((j-24+i*Interval):(j-2*24+1+Interval+i*Interval)));
%     if ZT(j+i*Interval) < max(ZT((j-24+i*Interval)),ZT((j-2*24+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-24+i*Interval)),ZT((j-2*24+1+Interval+i*Interval)));
%     end
%     j = 358;  % 倒数第7行的倒数第一个值
%     if ZT(j+i*Interval) < max(ZT((j-2*24+Interval+i*Interval)),ZT((j-2*24+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-2*24+Interval+i*Interval)),ZT((j-2*24+1+Interval+i*Interval)));
%     end
%     %----------------------------------------------------------------------
%     for j = (384-2):-1:359 % 倒数第6行的前26-2个值挨个跟其在倒数第7行的值及其下一个值的最大值比较
%         if ZT(j+i*Interval) < max(ZT(((j-25)+i*Interval):((j-25+1)+i*Interval)))
%             ZT(j+i*Interval) = max(ZT(((j-25)+i*Interval):((j-25+1)+i*Interval)));
%         end
%     end
% %     for j = 383:384 % 倒数第6行的最后两个值依次跟倒数第7行的最后两个值比较
% %         if ZT(j+i*Interval) < max(ZT((382-25+i*Interval):((382-25+1)+i*Interval)))
% %             ZT(j+i*Interval) = max(ZT((382-25+i*Interval):((382-25+1)+i*Interval)));
% %         end
% %     end
%     j = 383; %:358 % 倒数第6行的倒数第二个值
%     if ZT(j+i*Interval) < max(ZT((j-25+i*Interval)),ZT((j-2*25+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-25+i*Interval)),ZT((j-2*25+1+Interval+i*Interval)));
%     end
%     j = 384;  % 倒数第6行的倒数第一个值
% %     aa = ZT((j-2*25+Interval+i*Interval));
% %     bb = ZT((j-2*25+1+Interval+i*Interval));
% %     a = max(ZT((j-2*25+Interval+i*Interval)),ZT((j-2*25+1+Interval+i*Interval)));
% %     b = ZT(j+i*Interval);
%     if ZT(j+i*Interval) < max(ZT((j-2*25+Interval+i*Interval)),ZT((j-2*25+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-2*25+Interval+i*Interval)),ZT((j-2*25+1+Interval+i*Interval)));
%     end
% %     b = ZT(j+i*Interval);
%     %----------------------------------------------------------------------
%     for j = (411-2):-1:385 % 倒数第五行的前27-2个值挨个跟其在倒数第六行的值及其下一个值的最大值比较
%         if ZT(j+i*Interval) < max(ZT(((j-26)+i*Interval):((j-26+1)+i*Interval)))
%             ZT(j+i*Interval) = max(ZT(((j-26)+i*Interval):((j-26+1)+i*Interval)));
%         end
%     end
% %     for j = 410:411 % 倒数第五行的最后两个值依次跟倒数第六行的最后两个值比较
% %         if ZT(j+i*Interval) < max(ZT((409-26+i*Interval):((409-26+1)+i*Interval)))
% %             ZT(j+i*Interval) = max(ZT((409-26+i*Interval):((409-26+1)+i*Interval)));
% %         end
% %     end
%     j = 410; %:358 % 倒数第5行的倒数第二个值
%     if ZT(j+i*Interval) < max(ZT((j-26+i*Interval)),ZT((j-2*26+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-26+i*Interval)),ZT((j-2*26+1+Interval+i*Interval)));%%%%%%%%%%%%%
%     end
%     j = 411;  % 倒数第5行的倒数第一个值
%     if ZT(j+i*Interval) < max(ZT((j-2*26+Interval+i*Interval)),ZT((j-2*26+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-2*26+Interval+i*Interval)),ZT((j-2*26+1+Interval+i*Interval)));
%     end
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% end
%


for i = 15:-1:0 %块调整,一共十六块，但第三块（i=2）只调整倒4行
%     if (i ~= 2)&&(i ~= 6)&&(i ~= 9)
        %-----------------------------------------------------
        for j = (384-2):-1:359 % 倒数第六行的前26-2个值挨个跟其在倒数第七行的值及其下一个值的最大值比较
            if ZT(j+i*Interval) < max(ZT(((j-25)+i*Interval):((j-25+1)+i*Interval)))
                ZT(j+i*Interval) = max(ZT(((j-25)+i*Interval):((j-25+1)+i*Interval)));
            end
        end
        
        %      for j = 438:439 % 倒数第四行的最后两个值依次跟倒数第五行的最后两个值比较
        %         if ZT(j+i*Interval) < max(ZT((437-27+i*Interval):((437-27+1)+i*Interval)))
        %             ZT(j+i*Interval) = max(ZT((437-27+i*Interval):((437-27+1)+i*Interval)));
        %         end
        %      end
        
        j = 383; %:358 % 倒数第6行的倒数第二个值
        if ZT(j+i*Interval) < max(ZT((j-25+i*Interval)),ZT((j-2*25+1+Interval+i*Interval)))
            ZT(j+i*Interval) = max(ZT((j-25+i*Interval)),ZT((j-2*25+1+Interval+i*Interval)));
        end
        j = 384;  % 倒数第6行的倒数第一个值
        if ZT(j+i*Interval) < max(ZT((j-2*25+Interval+i*Interval)),ZT((j-2*25+1+Interval+i*Interval)))
            ZT(j+i*Interval) = max(ZT((j-2*25+Interval+i*Interval)),ZT((j-2*25+1+Interval+i*Interval)));
        end
        %-----------------------------------------------------
        for j = (411-2):-1:385 % 倒数第五行的前27-2个值挨个跟其在倒数第六行的值及其下一个值的最大值比较
            if ZT(j+i*Interval) < max(ZT(((j-26)+i*Interval):((j-26+1)+i*Interval)))
                ZT(j+i*Interval) = max(ZT(((j-26)+i*Interval):((j-26+1)+i*Interval)));
            end
        end
        
        %      for j = 438:439 % 倒数第四行的最后两个值依次跟倒数第五行的最后两个值比较
        %         if ZT(j+i*Interval) < max(ZT((437-27+i*Interval):((437-27+1)+i*Interval)))
        %             ZT(j+i*Interval) = max(ZT((437-27+i*Interval):((437-27+1)+i*Interval)));
        %         end
        %      end
        j = 410; %:358 % 倒数第5行的倒数第二个值
        if ZT(j+i*Interval) < max(ZT((j-26+i*Interval)),ZT((j-2*26+1+Interval+i*Interval)))
            ZT(j+i*Interval) = max(ZT((j-26+i*Interval)),ZT((j-2*26+1+Interval+i*Interval)));
        end
        j = 411;  % 倒数第5行的倒数第一个值
        if ZT(j+i*Interval) < max(ZT((j-2*26+Interval+i*Interval)),ZT((j-2*26+1+Interval+i*Interval)))
            ZT(j+i*Interval) = max(ZT((j-2*26+Interval+i*Interval)),ZT((j-2*26+1+Interval+i*Interval)));
        end
%     end
    %-----------------------------------------------------
    for j = (439-2):-1:412 % 倒数第四行的前28-2个值挨个跟其在倒数第五行的值及其下一个值的最大值比较
        if ZT(j+i*Interval) < max(ZT(((j-27)+i*Interval):((j-27+1)+i*Interval)))
            ZT(j+i*Interval) = max(ZT(((j-27)+i*Interval):((j-27+1)+i*Interval)));
        end
    end
    
    %      for j = 438:439 % 倒数第四行的最后两个值依次跟倒数第五行的最后两个值比较
    %         if ZT(j+i*Interval) < max(ZT((437-27+i*Interval):((437-27+1)+i*Interval)))
    %             ZT(j+i*Interval) = max(ZT((437-27+i*Interval):((437-27+1)+i*Interval)));
    %         end
    %      end
    j = 438; %:358 % 倒数第4行的倒数第二个值
    if ZT(j+i*Interval) < max(ZT((j-27+i*Interval)),ZT((j-2*27+1+Interval+i*Interval)))
        ZT(j+i*Interval) = max(ZT((j-27+i*Interval)),ZT((j-2*27+1+Interval+i*Interval)));
    end
    j = 439;  % 倒数第4行的倒数第一个值
    if ZT(j+i*Interval) < max(ZT((j-2*27+Interval+i*Interval)),ZT((j-2*27+1+Interval+i*Interval)))
        ZT(j+i*Interval) = max(ZT((j-2*27+Interval+i*Interval)),ZT((j-2*27+1+Interval+i*Interval)));
    end
    %------------------------------------------------------
    for j = (468-2):-1:440 % 倒数第三行的前29-2个值挨个跟其在倒数第三行的值及其下一个值的最大值比较
        if ZT(j+i*Interval) < max(ZT(((j-28)+i*Interval):((j-28+1)+i*Interval)))
            ZT(j+i*Interval) = max(ZT(((j-28)+i*Interval):((j-28+1)+i*Interval)));
        end
    end
    
    %      for j = 467:468 % 倒数第三行的最后两个值依次跟倒数第四行的最后两个值比较
    %         if ZT(j+i*Interval) < max(ZT((466-28+i*Interval):((466-28+1)+i*Interval)))
    %             ZT(j+i*Interval) = max(ZT((466-28+i*Interval):((466-28+1)+i*Interval)));
    %         end
    %      end
    j = 467; %:358 % 倒数第3行的倒数第二个值
    if ZT(j+i*Interval) < max(ZT((j-28+i*Interval)),ZT((j-2*28+1+Interval+i*Interval)))
        ZT(j+i*Interval) = max(ZT((j-28+i*Interval)),ZT((j-2*28+1+Interval+i*Interval)));
    end
    j = 468;  % 倒数第3行的倒数第一个值
    if ZT(j+i*Interval) < max(ZT((j-2*28+Interval+i*Interval)),ZT((j-2*28+1+Interval+i*Interval)))
        ZT(j+i*Interval) = max(ZT((j-2*28+Interval+i*Interval)),ZT((j-2*28+1+Interval+i*Interval)));
    end
    %--------------------------------------------------------
    for j = (498-2):-1:469 % 倒数第二行的前30-2个值挨个跟其在倒数第三行的值及其下一个值的最大值比较
        if ZT(j+i*Interval) < max(ZT(((j-29)+i*Interval):((j-29+1)+i*Interval)))
            ZT(j+i*Interval) = max(ZT(((j-29)+i*Interval):((j-29+1)+i*Interval)));
        end
    end
    
    %     for j = 497:498 % 倒数第二行的最后两个值依次跟倒数第三行的最后两个值比较
    %         if ZT(j+i*Interval) < max(ZT((496-29+i*Interval):((496-29+1)+i*Interval)))
    %             ZT(j+i*Interval) = max(ZT((496-29+i*Interval):((496-29+1)+i*Interval)));
    %         end
    %     end
    j = 497; %:358 % 倒数第2行的倒数第二个值
    if ZT(j+i*Interval) < max(ZT((j-29+i*Interval)),ZT((j-2*29+1+Interval+i*Interval)))
        ZT(j+i*Interval) = max(ZT((j-29+i*Interval)),ZT((j-2*29+1+Interval+i*Interval)));
    end
    j = 498;  % 倒数第2行的倒数第一个值
    if ZT(j+i*Interval) < max(ZT((j-2*29+Interval+i*Interval)),ZT((j-2*29+1+Interval+i*Interval)))
        ZT(j+i*Interval) = max(ZT((j-2*29+Interval+i*Interval)),ZT((j-2*29+1+Interval+i*Interval)));
    end
    %-----------------------------------------------------------
    for j = (529-2):-1:499 % 倒数第一行的前31-2个值挨个跟其在倒数第二行的值及其下一个值的最大值比较
        if ZT(j+i*Interval) < max(ZT(((j-30)+i*Interval):((j-30+1)+i*Interval)))
            ZT(j+i*Interval) = max(ZT(((j-30)+i*Interval):((j-30+1)+i*Interval)));
        end
    end
    
    %     for j = 528:529 % 倒数第一行的最后两个值依次跟倒数第二行的最后两个值比较
    %         if ZT(j+i*Interval) < max(ZT((527-30+i*Interval):((527-30+1)+i*Interval)))
    %             ZT(j+i*Interval) = max(ZT((527-30+i*Interval):((527-30+1)+i*Interval)));
    %         end
    %     end
    j = 528; %:358 % 倒数第1行的倒数第二个值
    if ZT(j+i*Interval) < max(ZT((j-30+i*Interval)),ZT((j-2*30+1+Interval+i*Interval)))
        ZT(j+i*Interval) = max(ZT((j-30+i*Interval)),ZT((j-2*30+1+Interval+i*Interval)));
    end
    j = 529;  % 倒数第1行的倒数第一个值
    if ZT(j+i*Interval) < max(ZT((j-2*30+Interval+i*Interval)),ZT((j-2*30+1+Interval+i*Interval)))
        ZT(j+i*Interval) = max(ZT((j-2*30+Interval+i*Interval)),ZT((j-2*30+1+Interval+i*Interval)));
    end
    
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%调每行的后两个%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for i=0:9
%     j = 357; %:358 % 倒数第7行的倒数第二个值
%     if ZT(j+i*Interval) < max(ZT((j-24+i*Interval)),ZT((j-2*24+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-24+i*Interval)),ZT((j-2*24+1+Interval+i*Interval)));
%     end
%     j = 358;  % 倒数第7行的倒数第一个值
%     if ZT(j+i*Interval) < max(ZT((j-2*24+Interval+i*Interval)),ZT((j-2*24+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-2*24+Interval+i*Interval)),ZT((j-2*24+1+Interval+i*Interval)));
%     end
%     %++++++++++++++++++++++++
%     j = 383; %:358 % 倒数第6行的倒数第二个值
%     if ZT(j+i*Interval) < max(ZT((j-25+i*Interval)),ZT((j-2*25+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-25+i*Interval)),ZT((j-2*25+1+Interval+i*Interval)));
%     end
%     j = 384;  % 倒数第6行的倒数第一个值
%     if ZT(j+i*Interval) < max(ZT((j-2*25+Interval+i*Interval)),ZT((j-2*25+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-2*25+Interval+i*Interval)),ZT((j-2*25+1+Interval+i*Interval)));
%     end
%     %+++++++++++++++++++++++++
%     j = 410; %:358 % 倒数第5行的倒数第二个值
%     if ZT(j+i*Interval) < max(ZT((j-26+i*Interval)),ZT((j-2*26+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-26+i*Interval)),ZT((j-2*26+1+Interval+i*Interval)));
%     end
%     j = 411;  % 倒数第5行的倒数第一个值
%     if ZT(j+i*Interval) < max(ZT((j-2*26+Interval+i*Interval)),ZT((j-2*26+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-2*26+Interval+i*Interval)),ZT((j-2*26+1+Interval+i*Interval)));
%     end
% end
%
% for i=0:15
%     j = 438; %:358 % 倒数第4行的倒数第二个值
%     if ZT(j+i*Interval) < max(ZT((j-27+i*Interval)),ZT((j-2*27+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-27+i*Interval)),ZT((j-2*27+1+Interval+i*Interval)));
%     end
%     j = 439;  % 倒数第4行的倒数第一个值
%     if ZT(j+i*Interval) < max(ZT((j-2*27+Interval+i*Interval)),ZT((j-2*27+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-2*27+Interval+i*Interval)),ZT((j-2*27+1+Interval+i*Interval)));
%     end
%     %+++++++++++++++++++++++++++++++++++++++++++++++++++
%     j = 467; %:358 % 倒数第3行的倒数第二个值
%     if ZT(j+i*Interval) < max(ZT((j-28+i*Interval)),ZT((j-2*28+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-28+i*Interval)),ZT((j-2*28+1+Interval+i*Interval)));
%     end
%     j = 468;  % 倒数第3行的倒数第一个值
%     if ZT(j+i*Interval) < max(ZT((j-2*28+Interval+i*Interval)),ZT((j-2*28+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-2*28+Interval+i*Interval)),ZT((j-2*28+1+Interval+i*Interval)));
%     end
%     %+++++++++++++++++++++++++++++++++++++++++++++++++++
%     j = 497; %:358 % 倒数第2行的倒数第二个值
%     if ZT(j+i*Interval) < max(ZT((j-29+i*Interval)),ZT((j-2*29+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-29+i*Interval)),ZT((j-2*29+1+Interval+i*Interval)));
%     end
%     j = 498;  % 倒数第2行的倒数第一个值
%     if ZT(j+i*Interval) < max(ZT((j-2*29+Interval+i*Interval)),ZT((j-2*29+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-2*29+Interval+i*Interval)),ZT((j-2*29+1+Interval+i*Interval)));
%     end
%     %++++++++++++++++++++++++++++++++++++++++++++++++++++
%      j = 528; %:358 % 倒数第1行的倒数第二个值
%     if ZT(j+i*Interval) < max(ZT((j-30+i*Interval)),ZT((j-2*30+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-30+i*Interval)),ZT((j-2*30+1+Interval+i*Interval)));
%     end
%     j = 529;  % 倒数第1行的倒数第一个值
%     if ZT(j+i*Interval) < max(ZT((j-2*30+Interval+i*Interval)),ZT((j-2*30+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-2*30+Interval+i*Interval)),ZT((j-2*30+1+Interval+i*Interval)));
%     end
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 调整内耳延展区
%这里的比较思路还是与上一行去比，只不过不是整行来调整
%调整内1区
pre_num = 9535-31-31-33;

for i = 360:-1:359
    %     display('if 之前')
    if ZT(i + pre_num) < ZT(i + pre_num+1) %调整倒数斜6
        %          display('if 之后')
        ZT(i + pre_num) = ZT(i + pre_num+1);
    end
end

for j = 387:-1:385
    if ZT(j + pre_num) < ZT(j + pre_num+1) %调整倒数斜5
        ZT(j + pre_num) = ZT(j + pre_num+1);
    end
end

for i = 415:-1:412
    if ZT(i + pre_num) < ZT(i + pre_num+1)%调整倒数斜4
        ZT(i + pre_num) = ZT(i + pre_num+1);
    end
end

for i = 444:-1:440
    if ZT(i + pre_num) < ZT(i + pre_num+1) %调整倒数斜3
        ZT(i + pre_num) = ZT(i + pre_num+1);
    end
end

for i = 474:-1:469
    if ZT(i + pre_num) < ZT(i + pre_num+1) %调整倒数斜2
        ZT(i + pre_num) = ZT(i + pre_num+1);
    end
end

for i = 505:-1:499
    if ZT(i + pre_num) < ZT(i + pre_num+1)%调整倒数斜1
        ZT(i + pre_num) = ZT(i + pre_num+1);
    end
end

% 调整内2区

pre_num = 10062-31-31-31-33;

for i = 362:-1:359
    if ZT(i + pre_num) < max(ZT(i - 25 + pre_num):ZT(i + pre_num+1)) %调整倒数斜6
        ZT(i + pre_num) = max(ZT(i - 25 + pre_num):ZT(i + pre_num+1));
    end
end

for i = 389:-1:385
    if ZT(i + pre_num) < max(ZT(i - 26 + pre_num):ZT(i + pre_num+1)) %调整倒数斜5
        ZT(i + pre_num) = max(ZT(i - 26 + pre_num):ZT(i + pre_num+1));
    end
end

for i = 417:-1:412
    if ZT(i + pre_num) < max(ZT(i - 27 + pre_num): ZT(i + pre_num+1))%调整倒数斜4
        ZT(i + pre_num) = max(ZT(i - 27 + pre_num): ZT(i + pre_num+1));
    end
end

for i = 446:-1:440
    if ZT(i + pre_num) < max(ZT(i - 28 + pre_num):ZT(i + pre_num+1)) %调整倒数斜3
        ZT(i + pre_num) = max(ZT(i - 28 + pre_num):ZT(i + pre_num+1));
    end
end

for i = 476:-1:469
    if ZT(i + pre_num) < max(ZT(i - 29 + pre_num):ZT(i + pre_num+1)) %调整倒数斜2
        ZT(i + pre_num) = max(ZT(i - 29 + pre_num):ZT(i + pre_num+1));
    end
end


for i = 505:-1:499
    if ZT(i + pre_num) < ZT(i + pre_num+1)%调整倒数斜1
        ZT(i + pre_num) = ZT(i + pre_num+1);
    end
end
%% 调整17&18区
%调整17区
pre_num = 8481;
for i = 470:-1:466
    if ZT(i + pre_num) < ZT(i + pre_num+1) %调整倒数第一排的5个
        ZT(i + pre_num) = ZT(i + pre_num+1);
    end
end
for i = 439:-1:436
    if ZT(i + pre_num) < ZT(i + pre_num+1) %调整倒数第二排的4个
        ZT(i + pre_num) = ZT(i + pre_num+1);
    end
end
for i = 409:-1:407
    if ZT(i + pre_num) < ZT(i + pre_num+1) %调整倒数第三排的3个
        ZT(i + pre_num) = ZT(i + pre_num+1);
    end
end
%调整18区
pre_num = 9008-31;
for i = 470:-1:466
    if ZT(i + pre_num) < ZT(i + pre_num+1) %调整倒数第一排的5个
        ZT(i + pre_num) = ZT(i + pre_num+1);
    end
end
for i = 439:-1:436
    if ZT(i + pre_num) < ZT(i + pre_num+1) %调整倒数第二排的4个
        ZT(i + pre_num) = ZT(i + pre_num+1);
    end
end
for i = 409:-1:407
    if ZT(i + pre_num) < ZT(i + pre_num+1) %调整倒数第三排的3个
        ZT(i + pre_num) = ZT(i + pre_num+1);
    end
end
%% 3\7\10区右下角三角调整的预处理--调整3区的边界初始点
i = 2;
ZT(529+i*Interval) = ZT(9939);
ZT(498+i*Interval) = ZT(9909);
ZT(468+i*Interval) = ZT(9880);
ZT(439+i*Interval) = ZT(9852);
ZT(411+i*Interval) = ZT(9825);
ZT(384+i*Interval) = ZT(9799);

%% 3\7\10区右下角三角调整
for i = 0:15
    var1 = linspace(ZT(517+i*Interval),ZT(529+i*Interval),13); %倒1行
    for j = 1:12
        ZT(517+j+i*Interval) = var1(j+1);
    end
    var2 = linspace(ZT(488+i*Interval),ZT(498+i*Interval),11); %倒2行
    for j = 1:10
        ZT(488+j+i*Interval) = var2(j+1);
    end
    var3 = linspace(ZT(460+i*Interval),ZT(468+i*Interval),9); %倒3行
    for j = 1:8
        ZT(460+j+i*Interval) = var3(j+1);
    end
    var4 = linspace(ZT(433+i*Interval),ZT(439+i*Interval),7); %倒4行
    for j = 1:6
        ZT(433+j+i*Interval) = var4(j+1);
    end
    var5 = linspace(ZT(407+i*Interval),ZT(411+i*Interval),5); %倒5行
    for j = 1:4
        ZT(407+j+i*Interval) = var5(j+1);
    end
    var6 = linspace(ZT(382+i*Interval),ZT(384+i*Interval),3); %倒6行
    for j = 1:2
        ZT(382+j+i*Interval) = var6(j+1);
    end
end
%% 再次线调整
PA = 1+32;
PM = 1+32+496;
PB = 1+32+496+32;
for i = [0,1,3:5,7,8,10:15]
    ZT(32+PM+i*Interval) = (ZT(496+PA+i*Interval)+ZT(466+PB+i*Interval))/2;
    ZT(31+PM+i*Interval) = (ZT(465+PA+i*Interval)+ZT(436+PB+i*Interval))/2;
    ZT(30+PM+i*Interval) = (ZT(435+PA+i*Interval)+ZT(407+PB+i*Interval))/2;
    ZT(29+PM+i*Interval) = (ZT(406+PA+i*Interval)+ZT(379+PB+i*Interval))/2;
    ZT(28+PM+i*Interval) = (ZT(378+PA+i*Interval)+ZT(352+PB+i*Interval))/2;
    ZT(27+PM+i*Interval) = (ZT(351+PA+i*Interval)+ZT(326+PB+i*Interval))/2;
end

for i = [2,6,9]
    ZT(32+PM+i*Interval) = ZT(529+i*Interval);
    ZT(31+PM+i*Interval) = ZT(498+i*Interval);
    ZT(30+PM+i*Interval) = ZT(468+i*Interval);
    ZT(29+PM+i*Interval) = ZT(439+i*Interval);
end


end





