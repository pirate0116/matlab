%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% code by zhangfeng 2010-5-20                                             %
%                                                                         %
% function: �˳������������˶��������Ե��ģ���³�������                     %
%                                                                         %
% ׼�����ں�6��                                                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ZT] = ModifyEdge( ZT )
%% ÿ��+ÿ��
Interval = 496+32;

%% �ߵ���


% for i = 0:10 %ǰ8���߽��е����е��ߵ���
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

pre_num = 10589-31-31-31-31-33;%��������3�����һ�У���8'��,����pre_num��10432
for i = 504:-1:499
    if ZT(i + pre_num) < ZT(i + pre_num+1)%��������б1
        ZT(i + pre_num) = ZT(i + pre_num+1);
    end
end
for i = 473:-1:469
    if ZT(i + pre_num) < ZT(i + pre_num+1) %��������б2
        ZT(i + pre_num) = ZT(i + pre_num+1);
    end
end


for i = 0:16  %�ߵ���
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

%% �����

% for i = 9:-1:0 %ǰ10��Ŀ����������7��
%     %---------------------------------------------------------------------
%     for j = (358-2):-1:334 % ������7�е�ǰ25-2��ֵ���������ڵ�����8�е�ֵ������һ��ֵ�����ֵ�Ƚ�
%         if ZT(j+i*Interval) < max(ZT(((j-24)+i*Interval):((j-24+1)+i*Interval)))
%             ZT(j+i*Interval) = max(ZT(((j-24)+i*Interval):((j-24+1)+i*Interval)));
%         end
%     end
%     j = 357; %:358 % ������7�еĵ����ڶ���ֵ
% %     aa = max(ZT((j-24+i*Interval):(j-2*24+1+Interval+i*Interval)));
%     if ZT(j+i*Interval) < max(ZT((j-24+i*Interval)),ZT((j-2*24+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-24+i*Interval)),ZT((j-2*24+1+Interval+i*Interval)));
%     end
%     j = 358;  % ������7�еĵ�����һ��ֵ
%     if ZT(j+i*Interval) < max(ZT((j-2*24+Interval+i*Interval)),ZT((j-2*24+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-2*24+Interval+i*Interval)),ZT((j-2*24+1+Interval+i*Interval)));
%     end
%     %----------------------------------------------------------------------
%     for j = (384-2):-1:359 % ������6�е�ǰ26-2��ֵ���������ڵ�����7�е�ֵ������һ��ֵ�����ֵ�Ƚ�
%         if ZT(j+i*Interval) < max(ZT(((j-25)+i*Interval):((j-25+1)+i*Interval)))
%             ZT(j+i*Interval) = max(ZT(((j-25)+i*Interval):((j-25+1)+i*Interval)));
%         end
%     end
% %     for j = 383:384 % ������6�е��������ֵ���θ�������7�е��������ֵ�Ƚ�
% %         if ZT(j+i*Interval) < max(ZT((382-25+i*Interval):((382-25+1)+i*Interval)))
% %             ZT(j+i*Interval) = max(ZT((382-25+i*Interval):((382-25+1)+i*Interval)));
% %         end
% %     end
%     j = 383; %:358 % ������6�еĵ����ڶ���ֵ
%     if ZT(j+i*Interval) < max(ZT((j-25+i*Interval)),ZT((j-2*25+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-25+i*Interval)),ZT((j-2*25+1+Interval+i*Interval)));
%     end
%     j = 384;  % ������6�еĵ�����һ��ֵ
% %     aa = ZT((j-2*25+Interval+i*Interval));
% %     bb = ZT((j-2*25+1+Interval+i*Interval));
% %     a = max(ZT((j-2*25+Interval+i*Interval)),ZT((j-2*25+1+Interval+i*Interval)));
% %     b = ZT(j+i*Interval);
%     if ZT(j+i*Interval) < max(ZT((j-2*25+Interval+i*Interval)),ZT((j-2*25+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-2*25+Interval+i*Interval)),ZT((j-2*25+1+Interval+i*Interval)));
%     end
% %     b = ZT(j+i*Interval);
%     %----------------------------------------------------------------------
%     for j = (411-2):-1:385 % ���������е�ǰ27-2��ֵ���������ڵ��������е�ֵ������һ��ֵ�����ֵ�Ƚ�
%         if ZT(j+i*Interval) < max(ZT(((j-26)+i*Interval):((j-26+1)+i*Interval)))
%             ZT(j+i*Interval) = max(ZT(((j-26)+i*Interval):((j-26+1)+i*Interval)));
%         end
%     end
% %     for j = 410:411 % ���������е��������ֵ���θ����������е��������ֵ�Ƚ�
% %         if ZT(j+i*Interval) < max(ZT((409-26+i*Interval):((409-26+1)+i*Interval)))
% %             ZT(j+i*Interval) = max(ZT((409-26+i*Interval):((409-26+1)+i*Interval)));
% %         end
% %     end
%     j = 410; %:358 % ������5�еĵ����ڶ���ֵ
%     if ZT(j+i*Interval) < max(ZT((j-26+i*Interval)),ZT((j-2*26+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-26+i*Interval)),ZT((j-2*26+1+Interval+i*Interval)));%%%%%%%%%%%%%
%     end
%     j = 411;  % ������5�еĵ�����һ��ֵ
%     if ZT(j+i*Interval) < max(ZT((j-2*26+Interval+i*Interval)),ZT((j-2*26+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-2*26+Interval+i*Interval)),ZT((j-2*26+1+Interval+i*Interval)));
%     end
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% end
%


for i = 15:-1:0 %�����,һ��ʮ���飬�������飨i=2��ֻ������4��
%     if (i ~= 2)&&(i ~= 6)&&(i ~= 9)
        %-----------------------------------------------------
        for j = (384-2):-1:359 % ���������е�ǰ26-2��ֵ���������ڵ��������е�ֵ������һ��ֵ�����ֵ�Ƚ�
            if ZT(j+i*Interval) < max(ZT(((j-25)+i*Interval):((j-25+1)+i*Interval)))
                ZT(j+i*Interval) = max(ZT(((j-25)+i*Interval):((j-25+1)+i*Interval)));
            end
        end
        
        %      for j = 438:439 % ���������е��������ֵ���θ����������е��������ֵ�Ƚ�
        %         if ZT(j+i*Interval) < max(ZT((437-27+i*Interval):((437-27+1)+i*Interval)))
        %             ZT(j+i*Interval) = max(ZT((437-27+i*Interval):((437-27+1)+i*Interval)));
        %         end
        %      end
        
        j = 383; %:358 % ������6�еĵ����ڶ���ֵ
        if ZT(j+i*Interval) < max(ZT((j-25+i*Interval)),ZT((j-2*25+1+Interval+i*Interval)))
            ZT(j+i*Interval) = max(ZT((j-25+i*Interval)),ZT((j-2*25+1+Interval+i*Interval)));
        end
        j = 384;  % ������6�еĵ�����һ��ֵ
        if ZT(j+i*Interval) < max(ZT((j-2*25+Interval+i*Interval)),ZT((j-2*25+1+Interval+i*Interval)))
            ZT(j+i*Interval) = max(ZT((j-2*25+Interval+i*Interval)),ZT((j-2*25+1+Interval+i*Interval)));
        end
        %-----------------------------------------------------
        for j = (411-2):-1:385 % ���������е�ǰ27-2��ֵ���������ڵ��������е�ֵ������һ��ֵ�����ֵ�Ƚ�
            if ZT(j+i*Interval) < max(ZT(((j-26)+i*Interval):((j-26+1)+i*Interval)))
                ZT(j+i*Interval) = max(ZT(((j-26)+i*Interval):((j-26+1)+i*Interval)));
            end
        end
        
        %      for j = 438:439 % ���������е��������ֵ���θ����������е��������ֵ�Ƚ�
        %         if ZT(j+i*Interval) < max(ZT((437-27+i*Interval):((437-27+1)+i*Interval)))
        %             ZT(j+i*Interval) = max(ZT((437-27+i*Interval):((437-27+1)+i*Interval)));
        %         end
        %      end
        j = 410; %:358 % ������5�еĵ����ڶ���ֵ
        if ZT(j+i*Interval) < max(ZT((j-26+i*Interval)),ZT((j-2*26+1+Interval+i*Interval)))
            ZT(j+i*Interval) = max(ZT((j-26+i*Interval)),ZT((j-2*26+1+Interval+i*Interval)));
        end
        j = 411;  % ������5�еĵ�����һ��ֵ
        if ZT(j+i*Interval) < max(ZT((j-2*26+Interval+i*Interval)),ZT((j-2*26+1+Interval+i*Interval)))
            ZT(j+i*Interval) = max(ZT((j-2*26+Interval+i*Interval)),ZT((j-2*26+1+Interval+i*Interval)));
        end
%     end
    %-----------------------------------------------------
    for j = (439-2):-1:412 % ���������е�ǰ28-2��ֵ���������ڵ��������е�ֵ������һ��ֵ�����ֵ�Ƚ�
        if ZT(j+i*Interval) < max(ZT(((j-27)+i*Interval):((j-27+1)+i*Interval)))
            ZT(j+i*Interval) = max(ZT(((j-27)+i*Interval):((j-27+1)+i*Interval)));
        end
    end
    
    %      for j = 438:439 % ���������е��������ֵ���θ����������е��������ֵ�Ƚ�
    %         if ZT(j+i*Interval) < max(ZT((437-27+i*Interval):((437-27+1)+i*Interval)))
    %             ZT(j+i*Interval) = max(ZT((437-27+i*Interval):((437-27+1)+i*Interval)));
    %         end
    %      end
    j = 438; %:358 % ������4�еĵ����ڶ���ֵ
    if ZT(j+i*Interval) < max(ZT((j-27+i*Interval)),ZT((j-2*27+1+Interval+i*Interval)))
        ZT(j+i*Interval) = max(ZT((j-27+i*Interval)),ZT((j-2*27+1+Interval+i*Interval)));
    end
    j = 439;  % ������4�еĵ�����һ��ֵ
    if ZT(j+i*Interval) < max(ZT((j-2*27+Interval+i*Interval)),ZT((j-2*27+1+Interval+i*Interval)))
        ZT(j+i*Interval) = max(ZT((j-2*27+Interval+i*Interval)),ZT((j-2*27+1+Interval+i*Interval)));
    end
    %------------------------------------------------------
    for j = (468-2):-1:440 % ���������е�ǰ29-2��ֵ���������ڵ��������е�ֵ������һ��ֵ�����ֵ�Ƚ�
        if ZT(j+i*Interval) < max(ZT(((j-28)+i*Interval):((j-28+1)+i*Interval)))
            ZT(j+i*Interval) = max(ZT(((j-28)+i*Interval):((j-28+1)+i*Interval)));
        end
    end
    
    %      for j = 467:468 % ���������е��������ֵ���θ����������е��������ֵ�Ƚ�
    %         if ZT(j+i*Interval) < max(ZT((466-28+i*Interval):((466-28+1)+i*Interval)))
    %             ZT(j+i*Interval) = max(ZT((466-28+i*Interval):((466-28+1)+i*Interval)));
    %         end
    %      end
    j = 467; %:358 % ������3�еĵ����ڶ���ֵ
    if ZT(j+i*Interval) < max(ZT((j-28+i*Interval)),ZT((j-2*28+1+Interval+i*Interval)))
        ZT(j+i*Interval) = max(ZT((j-28+i*Interval)),ZT((j-2*28+1+Interval+i*Interval)));
    end
    j = 468;  % ������3�еĵ�����һ��ֵ
    if ZT(j+i*Interval) < max(ZT((j-2*28+Interval+i*Interval)),ZT((j-2*28+1+Interval+i*Interval)))
        ZT(j+i*Interval) = max(ZT((j-2*28+Interval+i*Interval)),ZT((j-2*28+1+Interval+i*Interval)));
    end
    %--------------------------------------------------------
    for j = (498-2):-1:469 % �����ڶ��е�ǰ30-2��ֵ���������ڵ��������е�ֵ������һ��ֵ�����ֵ�Ƚ�
        if ZT(j+i*Interval) < max(ZT(((j-29)+i*Interval):((j-29+1)+i*Interval)))
            ZT(j+i*Interval) = max(ZT(((j-29)+i*Interval):((j-29+1)+i*Interval)));
        end
    end
    
    %     for j = 497:498 % �����ڶ��е��������ֵ���θ����������е��������ֵ�Ƚ�
    %         if ZT(j+i*Interval) < max(ZT((496-29+i*Interval):((496-29+1)+i*Interval)))
    %             ZT(j+i*Interval) = max(ZT((496-29+i*Interval):((496-29+1)+i*Interval)));
    %         end
    %     end
    j = 497; %:358 % ������2�еĵ����ڶ���ֵ
    if ZT(j+i*Interval) < max(ZT((j-29+i*Interval)),ZT((j-2*29+1+Interval+i*Interval)))
        ZT(j+i*Interval) = max(ZT((j-29+i*Interval)),ZT((j-2*29+1+Interval+i*Interval)));
    end
    j = 498;  % ������2�еĵ�����һ��ֵ
    if ZT(j+i*Interval) < max(ZT((j-2*29+Interval+i*Interval)),ZT((j-2*29+1+Interval+i*Interval)))
        ZT(j+i*Interval) = max(ZT((j-2*29+Interval+i*Interval)),ZT((j-2*29+1+Interval+i*Interval)));
    end
    %-----------------------------------------------------------
    for j = (529-2):-1:499 % ������һ�е�ǰ31-2��ֵ���������ڵ����ڶ��е�ֵ������һ��ֵ�����ֵ�Ƚ�
        if ZT(j+i*Interval) < max(ZT(((j-30)+i*Interval):((j-30+1)+i*Interval)))
            ZT(j+i*Interval) = max(ZT(((j-30)+i*Interval):((j-30+1)+i*Interval)));
        end
    end
    
    %     for j = 528:529 % ������һ�е��������ֵ���θ������ڶ��е��������ֵ�Ƚ�
    %         if ZT(j+i*Interval) < max(ZT((527-30+i*Interval):((527-30+1)+i*Interval)))
    %             ZT(j+i*Interval) = max(ZT((527-30+i*Interval):((527-30+1)+i*Interval)));
    %         end
    %     end
    j = 528; %:358 % ������1�еĵ����ڶ���ֵ
    if ZT(j+i*Interval) < max(ZT((j-30+i*Interval)),ZT((j-2*30+1+Interval+i*Interval)))
        ZT(j+i*Interval) = max(ZT((j-30+i*Interval)),ZT((j-2*30+1+Interval+i*Interval)));
    end
    j = 529;  % ������1�еĵ�����һ��ֵ
    if ZT(j+i*Interval) < max(ZT((j-2*30+Interval+i*Interval)),ZT((j-2*30+1+Interval+i*Interval)))
        ZT(j+i*Interval) = max(ZT((j-2*30+Interval+i*Interval)),ZT((j-2*30+1+Interval+i*Interval)));
    end
    
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%��ÿ�еĺ�����%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for i=0:9
%     j = 357; %:358 % ������7�еĵ����ڶ���ֵ
%     if ZT(j+i*Interval) < max(ZT((j-24+i*Interval)),ZT((j-2*24+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-24+i*Interval)),ZT((j-2*24+1+Interval+i*Interval)));
%     end
%     j = 358;  % ������7�еĵ�����һ��ֵ
%     if ZT(j+i*Interval) < max(ZT((j-2*24+Interval+i*Interval)),ZT((j-2*24+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-2*24+Interval+i*Interval)),ZT((j-2*24+1+Interval+i*Interval)));
%     end
%     %++++++++++++++++++++++++
%     j = 383; %:358 % ������6�еĵ����ڶ���ֵ
%     if ZT(j+i*Interval) < max(ZT((j-25+i*Interval)),ZT((j-2*25+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-25+i*Interval)),ZT((j-2*25+1+Interval+i*Interval)));
%     end
%     j = 384;  % ������6�еĵ�����һ��ֵ
%     if ZT(j+i*Interval) < max(ZT((j-2*25+Interval+i*Interval)),ZT((j-2*25+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-2*25+Interval+i*Interval)),ZT((j-2*25+1+Interval+i*Interval)));
%     end
%     %+++++++++++++++++++++++++
%     j = 410; %:358 % ������5�еĵ����ڶ���ֵ
%     if ZT(j+i*Interval) < max(ZT((j-26+i*Interval)),ZT((j-2*26+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-26+i*Interval)),ZT((j-2*26+1+Interval+i*Interval)));
%     end
%     j = 411;  % ������5�еĵ�����һ��ֵ
%     if ZT(j+i*Interval) < max(ZT((j-2*26+Interval+i*Interval)),ZT((j-2*26+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-2*26+Interval+i*Interval)),ZT((j-2*26+1+Interval+i*Interval)));
%     end
% end
%
% for i=0:15
%     j = 438; %:358 % ������4�еĵ����ڶ���ֵ
%     if ZT(j+i*Interval) < max(ZT((j-27+i*Interval)),ZT((j-2*27+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-27+i*Interval)),ZT((j-2*27+1+Interval+i*Interval)));
%     end
%     j = 439;  % ������4�еĵ�����һ��ֵ
%     if ZT(j+i*Interval) < max(ZT((j-2*27+Interval+i*Interval)),ZT((j-2*27+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-2*27+Interval+i*Interval)),ZT((j-2*27+1+Interval+i*Interval)));
%     end
%     %+++++++++++++++++++++++++++++++++++++++++++++++++++
%     j = 467; %:358 % ������3�еĵ����ڶ���ֵ
%     if ZT(j+i*Interval) < max(ZT((j-28+i*Interval)),ZT((j-2*28+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-28+i*Interval)),ZT((j-2*28+1+Interval+i*Interval)));
%     end
%     j = 468;  % ������3�еĵ�����һ��ֵ
%     if ZT(j+i*Interval) < max(ZT((j-2*28+Interval+i*Interval)),ZT((j-2*28+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-2*28+Interval+i*Interval)),ZT((j-2*28+1+Interval+i*Interval)));
%     end
%     %+++++++++++++++++++++++++++++++++++++++++++++++++++
%     j = 497; %:358 % ������2�еĵ����ڶ���ֵ
%     if ZT(j+i*Interval) < max(ZT((j-29+i*Interval)),ZT((j-2*29+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-29+i*Interval)),ZT((j-2*29+1+Interval+i*Interval)));
%     end
%     j = 498;  % ������2�еĵ�����һ��ֵ
%     if ZT(j+i*Interval) < max(ZT((j-2*29+Interval+i*Interval)),ZT((j-2*29+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-2*29+Interval+i*Interval)),ZT((j-2*29+1+Interval+i*Interval)));
%     end
%     %++++++++++++++++++++++++++++++++++++++++++++++++++++
%      j = 528; %:358 % ������1�еĵ����ڶ���ֵ
%     if ZT(j+i*Interval) < max(ZT((j-30+i*Interval)),ZT((j-2*30+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-30+i*Interval)),ZT((j-2*30+1+Interval+i*Interval)));
%     end
%     j = 529;  % ������1�еĵ�����һ��ֵ
%     if ZT(j+i*Interval) < max(ZT((j-2*30+Interval+i*Interval)),ZT((j-2*30+1+Interval+i*Interval)))
%         ZT(j+i*Interval) = max(ZT((j-2*30+Interval+i*Interval)),ZT((j-2*30+1+Interval+i*Interval)));
%     end
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% �����ڶ���չ��
%����ıȽ�˼·��������һ��ȥ�ȣ�ֻ������������������
%������1��
pre_num = 9535-31-31-33;

for i = 360:-1:359
    %     display('if ֮ǰ')
    if ZT(i + pre_num) < ZT(i + pre_num+1) %��������б6
        %          display('if ֮��')
        ZT(i + pre_num) = ZT(i + pre_num+1);
    end
end

for j = 387:-1:385
    if ZT(j + pre_num) < ZT(j + pre_num+1) %��������б5
        ZT(j + pre_num) = ZT(j + pre_num+1);
    end
end

for i = 415:-1:412
    if ZT(i + pre_num) < ZT(i + pre_num+1)%��������б4
        ZT(i + pre_num) = ZT(i + pre_num+1);
    end
end

for i = 444:-1:440
    if ZT(i + pre_num) < ZT(i + pre_num+1) %��������б3
        ZT(i + pre_num) = ZT(i + pre_num+1);
    end
end

for i = 474:-1:469
    if ZT(i + pre_num) < ZT(i + pre_num+1) %��������б2
        ZT(i + pre_num) = ZT(i + pre_num+1);
    end
end

for i = 505:-1:499
    if ZT(i + pre_num) < ZT(i + pre_num+1)%��������б1
        ZT(i + pre_num) = ZT(i + pre_num+1);
    end
end

% ������2��

pre_num = 10062-31-31-31-33;

for i = 362:-1:359
    if ZT(i + pre_num) < max(ZT(i - 25 + pre_num):ZT(i + pre_num+1)) %��������б6
        ZT(i + pre_num) = max(ZT(i - 25 + pre_num):ZT(i + pre_num+1));
    end
end

for i = 389:-1:385
    if ZT(i + pre_num) < max(ZT(i - 26 + pre_num):ZT(i + pre_num+1)) %��������б5
        ZT(i + pre_num) = max(ZT(i - 26 + pre_num):ZT(i + pre_num+1));
    end
end

for i = 417:-1:412
    if ZT(i + pre_num) < max(ZT(i - 27 + pre_num): ZT(i + pre_num+1))%��������б4
        ZT(i + pre_num) = max(ZT(i - 27 + pre_num): ZT(i + pre_num+1));
    end
end

for i = 446:-1:440
    if ZT(i + pre_num) < max(ZT(i - 28 + pre_num):ZT(i + pre_num+1)) %��������б3
        ZT(i + pre_num) = max(ZT(i - 28 + pre_num):ZT(i + pre_num+1));
    end
end

for i = 476:-1:469
    if ZT(i + pre_num) < max(ZT(i - 29 + pre_num):ZT(i + pre_num+1)) %��������б2
        ZT(i + pre_num) = max(ZT(i - 29 + pre_num):ZT(i + pre_num+1));
    end
end


for i = 505:-1:499
    if ZT(i + pre_num) < ZT(i + pre_num+1)%��������б1
        ZT(i + pre_num) = ZT(i + pre_num+1);
    end
end
%% ����17&18��
%����17��
pre_num = 8481;
for i = 470:-1:466
    if ZT(i + pre_num) < ZT(i + pre_num+1) %����������һ�ŵ�5��
        ZT(i + pre_num) = ZT(i + pre_num+1);
    end
end
for i = 439:-1:436
    if ZT(i + pre_num) < ZT(i + pre_num+1) %���������ڶ��ŵ�4��
        ZT(i + pre_num) = ZT(i + pre_num+1);
    end
end
for i = 409:-1:407
    if ZT(i + pre_num) < ZT(i + pre_num+1) %�������������ŵ�3��
        ZT(i + pre_num) = ZT(i + pre_num+1);
    end
end
%����18��
pre_num = 9008-31;
for i = 470:-1:466
    if ZT(i + pre_num) < ZT(i + pre_num+1) %����������һ�ŵ�5��
        ZT(i + pre_num) = ZT(i + pre_num+1);
    end
end
for i = 439:-1:436
    if ZT(i + pre_num) < ZT(i + pre_num+1) %���������ڶ��ŵ�4��
        ZT(i + pre_num) = ZT(i + pre_num+1);
    end
end
for i = 409:-1:407
    if ZT(i + pre_num) < ZT(i + pre_num+1) %�������������ŵ�3��
        ZT(i + pre_num) = ZT(i + pre_num+1);
    end
end
%% 3\7\10�����½����ǵ�����Ԥ����--����3���ı߽��ʼ��
i = 2;
ZT(529+i*Interval) = ZT(9939);
ZT(498+i*Interval) = ZT(9909);
ZT(468+i*Interval) = ZT(9880);
ZT(439+i*Interval) = ZT(9852);
ZT(411+i*Interval) = ZT(9825);
ZT(384+i*Interval) = ZT(9799);

%% 3\7\10�����½����ǵ���
for i = 0:15
    var1 = linspace(ZT(517+i*Interval),ZT(529+i*Interval),13); %��1��
    for j = 1:12
        ZT(517+j+i*Interval) = var1(j+1);
    end
    var2 = linspace(ZT(488+i*Interval),ZT(498+i*Interval),11); %��2��
    for j = 1:10
        ZT(488+j+i*Interval) = var2(j+1);
    end
    var3 = linspace(ZT(460+i*Interval),ZT(468+i*Interval),9); %��3��
    for j = 1:8
        ZT(460+j+i*Interval) = var3(j+1);
    end
    var4 = linspace(ZT(433+i*Interval),ZT(439+i*Interval),7); %��4��
    for j = 1:6
        ZT(433+j+i*Interval) = var4(j+1);
    end
    var5 = linspace(ZT(407+i*Interval),ZT(411+i*Interval),5); %��5��
    for j = 1:4
        ZT(407+j+i*Interval) = var5(j+1);
    end
    var6 = linspace(ZT(382+i*Interval),ZT(384+i*Interval),3); %��6��
    for j = 1:2
        ZT(382+j+i*Interval) = var6(j+1);
    end
end
%% �ٴ��ߵ���
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





