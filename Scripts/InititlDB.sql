﻿CREATE TABLE [dbo].[Courses] (
    [Id] [int] NOT NULL IDENTITY,
    [Title] [nvarchar](50) NOT NULL,
    [Credits] [int] NOT NULL,
    [DepartmentId] [int] NOT NULL,
    [CreatedDate] [datetime],
    [CreatedBy] [nvarchar](256),
    [UpdatedDate] [datetime],
    [UpdatedBy] [nvarchar](256),
    CONSTRAINT [PK_dbo.Courses] PRIMARY KEY ([Id])
)
CREATE INDEX [IX_DepartmentId] ON [dbo].[Courses]([DepartmentId])
CREATE TABLE [dbo].[Departments] (
    [Id] [int] NOT NULL IDENTITY,
    [Name] [nvarchar](150) NOT NULL,
    [Budget] [decimal](18, 2) NOT NULL,
    [StartDate] [datetime] NOT NULL,
    [InstructorId] [int],
    [RowVersion] [varbinary](max),
    [CreatedDate] [datetime],
    [CreatedBy] [nvarchar](256),
    [UpdatedDate] [datetime],
    [UpdatedBy] [nvarchar](256),
    CONSTRAINT [PK_dbo.Departments] PRIMARY KEY ([Id])
)
CREATE INDEX [IX_InstructorId] ON [dbo].[Departments]([InstructorId])
CREATE TABLE [dbo].[People] (
    [Id] [int] NOT NULL IDENTITY,
    [LastName] [nvarchar](150) NOT NULL,
    [FirstName] [nvarchar](150) NOT NULL,
    [MiddleName] [nvarchar](150),
    [Age] [int] NOT NULL,
    [Email] [nvarchar](150),
    [Phone] [nvarchar](150),
    [AddressLine1] [nvarchar](150),
    [AddressLine2] [nvarchar](150),
    [UnitOrApartmentNumber] [nvarchar](50),
    [City] [nvarchar](100),
    [State] [nvarchar](50),
    [ZipCode] [nvarchar](20),
    [CreatedDate] [datetime],
    [CreatedBy] [nvarchar](256),
    [UpdatedDate] [datetime],
    [UpdatedBy] [nvarchar](256),
    CONSTRAINT [PK_dbo.People] PRIMARY KEY ([Id])
)
CREATE TABLE [dbo].[OfficeAssignments] (
    [InstructorId] [int] NOT NULL,
    [Location] [nvarchar](150),
    [CreatedDate] [datetime],
    [CreatedBy] [nvarchar](256),
    [UpdatedDate] [datetime],
    [UpdatedBy] [nvarchar](256),
    CONSTRAINT [PK_dbo.OfficeAssignments] PRIMARY KEY ([InstructorId])
)
CREATE INDEX [IX_InstructorId] ON [dbo].[OfficeAssignments]([InstructorId])
CREATE TABLE [dbo].[Enrollments] (
    [Id] [int] NOT NULL IDENTITY,
    [CourseId] [int] NOT NULL,
    [StudentId] [int] NOT NULL,
    [Grade] [int],
    [CreatedDate] [datetime],
    [CreatedBy] [nvarchar](256),
    [UpdatedDate] [datetime],
    [UpdatedBy] [nvarchar](256),
    CONSTRAINT [PK_dbo.Enrollments] PRIMARY KEY ([Id])
)
CREATE INDEX [IX_CourseId] ON [dbo].[Enrollments]([CourseId])
CREATE INDEX [IX_StudentId] ON [dbo].[Enrollments]([StudentId])
CREATE TABLE [dbo].[InstructorCourses] (
    [Instructor_Id] [int] NOT NULL,
    [Course_Id] [int] NOT NULL,
    CONSTRAINT [PK_dbo.InstructorCourses] PRIMARY KEY ([Instructor_Id], [Course_Id])
)
CREATE INDEX [IX_Instructor_Id] ON [dbo].[InstructorCourses]([Instructor_Id])
CREATE INDEX [IX_Course_Id] ON [dbo].[InstructorCourses]([Course_Id])
CREATE TABLE [dbo].[Instructor] (
    [Id] [int] NOT NULL,
    [HireDate] [datetime] NOT NULL,
    CONSTRAINT [PK_dbo.Instructor] PRIMARY KEY ([Id])
)
CREATE INDEX [IX_Id] ON [dbo].[Instructor]([Id])
CREATE TABLE [dbo].[Student] (
    [Id] [int] NOT NULL,
    [EnrollmentDate] [datetime] NOT NULL,
    CONSTRAINT [PK_dbo.Student] PRIMARY KEY ([Id])
)
CREATE INDEX [IX_Id] ON [dbo].[Student]([Id])
ALTER TABLE [dbo].[Courses] ADD CONSTRAINT [FK_dbo.Courses_dbo.Departments_DepartmentId] FOREIGN KEY ([DepartmentId]) REFERENCES [dbo].[Departments] ([Id]) ON DELETE CASCADE
ALTER TABLE [dbo].[Departments] ADD CONSTRAINT [FK_dbo.Departments_dbo.Instructor_InstructorId] FOREIGN KEY ([InstructorId]) REFERENCES [dbo].[Instructor] ([Id])
ALTER TABLE [dbo].[OfficeAssignments] ADD CONSTRAINT [FK_dbo.OfficeAssignments_dbo.Instructor_InstructorId] FOREIGN KEY ([InstructorId]) REFERENCES [dbo].[Instructor] ([Id])
ALTER TABLE [dbo].[Enrollments] ADD CONSTRAINT [FK_dbo.Enrollments_dbo.Courses_CourseId] FOREIGN KEY ([CourseId]) REFERENCES [dbo].[Courses] ([Id]) ON DELETE CASCADE
ALTER TABLE [dbo].[Enrollments] ADD CONSTRAINT [FK_dbo.Enrollments_dbo.Student_StudentId] FOREIGN KEY ([StudentId]) REFERENCES [dbo].[Student] ([Id])
ALTER TABLE [dbo].[InstructorCourses] ADD CONSTRAINT [FK_dbo.InstructorCourses_dbo.Instructor_Instructor_Id] FOREIGN KEY ([Instructor_Id]) REFERENCES [dbo].[Instructor] ([Id]) ON DELETE CASCADE
ALTER TABLE [dbo].[InstructorCourses] ADD CONSTRAINT [FK_dbo.InstructorCourses_dbo.Courses_Course_Id] FOREIGN KEY ([Course_Id]) REFERENCES [dbo].[Courses] ([Id]) ON DELETE CASCADE
ALTER TABLE [dbo].[Instructor] ADD CONSTRAINT [FK_dbo.Instructor_dbo.People_Id] FOREIGN KEY ([Id]) REFERENCES [dbo].[People] ([Id])
ALTER TABLE [dbo].[Student] ADD CONSTRAINT [FK_dbo.Student_dbo.People_Id] FOREIGN KEY ([Id]) REFERENCES [dbo].[People] ([Id])
CREATE TABLE [dbo].[__MigrationHistory] (
    [MigrationId] [nvarchar](150) NOT NULL,
    [ContextKey] [nvarchar](300) NOT NULL,
    [Model] [varbinary](max) NOT NULL,
    [ProductVersion] [nvarchar](32) NOT NULL,
    CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY ([MigrationId], [ContextKey])
)
INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
VALUES (N'201704191904180_InitialDB', N'Contoso.Data.Migrations.Configuration',  0x1F8B0800000000000400ED1DDB6EE4B6F5BD40FF41D053526C3CB6B72952632681AFA9517BEDEED841D197012D71C64274994A1AC746D12FEB433FA9BF505237DE2952D268D68B41808D4D918787E77E7839FEDF7FFE3BFDE9350A9D1798664112CFDCA38343D781B197F841BC9AB99B7CF9DD0FEE4F3FFEFE77D34B3F7A757EA9FB7DC4FDD0C8389BB9CF79BE3E994C32EF1946203B88022F4DB264991F784934017E32393E3CFCF3E4E86802110817C1729CE9E74D9C07112C7E41BF9E27B107D7F90684B7890FC3AC6A475FE60554E7138860B6061E9CB9D7710ED39700FEF6B70DCC7284CD19887F3DB80039709DD3300008A3390C97AE03E238C901EE71F298C1799E26F16ABE460D207C785B43D46F09C20C56EB3821DD4D9774788C973421036B50DE26CB93C812E0D1C78A46137E78274ABB0D0D11152F11B5F337BCEA829233F73CD9A478E9FC5427E7618ABBE11E718E801F140C3928FB7F7098D60F8D3C20B1C1FFA1EF9B30DFA47016C34D9E02D4E37EF31406DE5FE1DB43F22B8C67F1260C69CC106EE81BD3809AEED3640DD3FCED335C56F85EFBAE3361C74DF881CD306A4CB91624321F8F5DE7139A1C3C85B0613CB5EE799EA4F06718C314E4D0BF073912B218C38005E984D9B9B91E823C84F57448D490F6B8CE2D78BD81F12A7F9EB9DF2375B90A5EA15F3754183CC601D23534264F375082A17ED6F314FA419EB52D530FE402AE419A47689DED046B4507130FA962430AFCF3035274C3A1676F1A1A1E7FFF272322EA677A5CFB5D91AC866E03C94FE025581592A8E48EEB7C8661D1257B0ED6A5913B209F17A58A2261B84A93E873123283EBAF8B0790AE2082F59028BBCCD1FF3D0B142FE33409430C2293E248BE2F6AB34350143E0A188A3D6C11BC8E3344740F69B81C41F25D4644F1AB80A2A48B0CC7E984D861AD75A6996E6AA1C998BD9556CD85FFD5E8EED176ACF4D9C62FA5A53436D00B2210BACE7D8A7EAAA2AE1F5C67EE010CD1DEEACE73C477B939B38444C458608A7EE0E7E4B74AC6EA6167410CD23786BAE8473975F74E656CA772EA47411C206603C4EB36BFC275967A17A64F63FB243E86ED58DB5153BC1BEB3C8427D460C9DBF94E469C6893B91127630632E2CE19C8602557984AF7080AD252AD44FE254861377BD28971D6DE97679CC6419BE277B75C061E3CCDB260152B632DBED382E630C158D34D081C747D7B4510E2824C45901FB9C368827147D67185DA9959BAC59BC4ABD2F0DE91C3DED58D83A435CB0D72876DD904DE9C99D88F4E36812452E6D6808CD967154ADD2B9C4E5F2B33CF37FE007B303FA7C027390E16D1AA656F7AC68EB2EBCD8EFE5B22BC89506F9A98E256499B14B9EADB82D9D721E8493E0B718DAC4FAF78A6C1D7D470550376184693B50F1C4CB7EDB775E01F2F603A1E77E25F453063F695FD87E2DEE913CE38BDBCD2E0AFD007DD802CDFCDEED65590EE6AEADBC0F74338D0DCFAA94E57B09F5FBE8C40106E1DCDFBE7241E8118BE9FC22CBB09627834E664C75B9F0C75CEEFD2D37A23E8D3267A8269FF63BD9600AAD06FF5CA0E8798649E534E685B2BF947B03E4F7CDD34C7FB3C7977C1AADA5B6F22CA575709C37576158215B92561EABA8BE14379EEC7D88769F886564F1B5F967AB7106B696D2E5CE717106ED04F870299998E674DC7237DC7F3A6A3780EC274BC683A7ED477BC6A3AFE516450C90ABAF134CB122F28682E6C4A345BA6EC7497B1EFB4EF9F927896DEB5B8458C09D68815485266EE1F84A56861378900815D27385AB8D309B54AFDE2755B2E2A4C8DF65F08CAE2EE298BFCE1C181283466B34908A426BE38098A48618A4342102205C3516D10E762F81AC45EB006A1393E1C08C31818F3AD998CFF7201D730C6E1AB390F8CB0D0EC0A637C9A69B968BD8D721612A83C1C530944FB49199106FAECDF5C155B8FD88CE44D2AD79D44AE0D9F11E4AD8DE8EF4FD8DA6CBDEE90D344C08E789A4CEFE20B18C21C3AA75E798FF11C649E6C3B11392EDF02ADAE6E620071E42833AE2072EB37999CBD9EB7131114772B55ACD66C5D124ED3E710E6164E7351AC4D880695EB4EF2A7447E04F153F2C4646E72B6B113C9936D65AA0444BBAF4944A4D9491EC5F66937CBBBA9442701D410670411D450C16476EA686C04292C73649CBEA211240B2CD3D98B27FC037C959D443C66B04A8933E9467309780E73FE520CC9CA39332618431600710D3220B49F6F01C487E63270624ED40294397E10C0D112DF02A83C0B9001A94F15380014630914D93523AAA3FA32122F7146B975B3060A7D41768D32690A5283376F80D8051B10437B6D41A48A71CA6D9D7453AB9308A186622639763B133A904E7D3352A49B59A268972A528B62F45F43ABD6E470DB84D2285C5B7A639AE0F423CB284A2739F417E9D1126B1B46DB14FE8C19D650431D5F6F8518D2436A911CAD01A0710868699175819B19753544A937E29B20A3F9369D940F1EAB86E944F132727A0BD6EB205E512F25AB16675E3E933CFF6E6EFF6E302A614C3C86CA7C48D4CC846C085841EE2B96121F16C7C2F851E613C0827EEE47926E5C48A50803EAE9D8A849645D1D1CD4FDF1CFB5EF573D193D902B1921E7155A21666FB15828A88238D0C16F56410852C96D80F324DC44B13AA4568FAEDE17D200AA267318CD6B411A4AD3680E87DD91A081E9F72AB49891B3320E3BF2C11A1E3E4093403B136E53E86031E7783434E683353C1E37AA5984359D70D228644182F40B292AAB4C46AA463BD281D48D4A4AEC554E37783B6A57DE2DA1C7972DE610EAC75F348CBACD1C0AF5C68B0644359BC362F7B419DA6877BBD510E9E75F343CBA7D6F0CDEB931A883A6810C813A83343004BAC1DB3104E44D140D83B40ECFA6EEA4AD7738EDE9AA1CB91DA2F237646948FCB7F1099CE19FEF96DF68285DEAC4B71D282DBB40BC3D4293DBA1340CD26A0E89BAED4983A29ACD61D1D737696074BB39B4E286260DA668B010C6F2822623836593398CEAFA250DA36AB2580773B9925910F3A513C4632544E16E930EA2E29A24E3C2E45D2CDC76712B92F1D8927BD03A08D595472E60B273D0CD8D461A4AD3B80F6ADE795023EE390FE48385D3127B17D10E62BC089F3C81651C48D3BA5784A114A15F00B02335D2EFCE765220EA7CD05E757483B71361917B128C142A6F4FA8215187DDACE7529E81AB615537B96938D2D7A0DA95ED1576A79E8B3D4460F54E76A66D997D9381EA245B7D10A5743CEDD7ECCC94900094DFFEA070E8849EF2168A117AD541991D6AFCB990C875E17888EFD2C85C734CC41D074DABA399F66A9AC2594DD90597A74A5E021F9FD3CCDFB21C46D5DEC23FC3F330286E6DD41D6E411C2C918095CF36DCE3C3A363AE10E79753147392657E2839DA122B63B22C1BE18D688069DAFA0AD4F2D5215396327E01A9F70C52E1DD57BFAA9305E203D49C0CA4CFBBAF631FBECEDC7F15034F9CEBBF2FE8B11F9CBB1489E08973E8FC7B887295D8CEE7DCEB6C8B1769E4C59694D6C59B2D3BC09257645D71145E9575C3B14B11C3AF4399CA1D290DED8E3A28135B1CD0DF7A714099F4742E0E68AAB2F45895CA9A88B0586710B1E1A92835F84D045EBFEDA8B67B0BB01D0B20AD92F15EB59FAFB0309805100A280C0659AC8F6002DAB21C4217F7CF1443180A27A6F6C1600B95943AD802ECE3A1616B0B19180482B6750BE4781F5AC364CA140C84275795406EF4EC57BFF71DDBF41DFADDEF5D15901C32E0E9547B7228FBB097DE6170E44443CBDD2E851ABF8ED889AF9068AA46F5B85E2A241456349DBD19D86B7AA6202327247B4DDDB99FD1EF72DBFA19F956B0EA59ADA4B78D5B5AF4F14B8BBE9B6764055D74DA6EFA2E35D77763394D78D08FF07C7576C30D1DEB4A9B5F2BFDE465397B52D1A44493F4284CFA06D4B83A10CF92419EAC0B16518ECD56EB75686F079B089E63F33CBDEDA4B393D11FA33C82E18126C55C094B47A899F16509970D93772058DA43E51184AA4B7DB50EB68B67A5FA6977FFD26CEFC006195C18B4DBE018495AAC6BA1598B4A4BB13DBACC45C7326AEF403CB4EFE6BE74C130AF5BB6DB4265C6CE71F0AA64638890850B7A5735C7761DD2D0956CC62CE9345E18A3BD8BAB0A60DE53CD30B302616A1FB42B1150BFF4DBB50C8C5BB24B9B19618610700BFC873016E5CD84C5436212DC56D71868CED64DE622324CD8D3494A546F0DB799EFF4986D4413A1170DF94ED8C072616181DEA344F4B750A3D5F7E36BD6F01C9315EFD3D4EE2BEF51CF5CFF2941CC2D771455E59378E074E42B4C407F944DA2297FA528ADA7A9AC279BE01E266BB1F24C6B5141A39A82B2F95A0BC3694A0FB6541E944DA72BE9C44F24EE5809D3895D6493F2BD6CA6D64EDA365DEB3C8D31122669BEC866683E72E00D6B333665BB4C4A342A1E9928BC6FB3401D195A362DA53014553BED6BA369AA411A9143FEA845923251CB9023BF53328C52A4B29F64A86C9CFC016F7F926CB9F8643F62885E8BAFDA342801862F2A6988763755FA120A4676D37BD19BF28F6CFB2F759BE52019AC157E69F405774950F5D6BF5B9E2BCD68A845DF4B4B2CF7B31A3DE4C32C63D3484E87946F00125948E2306543C5F79F2863DAC4F88A43F9DB05C46EA90131453063E831B952D3E73A5E2675BAC6615477E15F1EC01CF828913A4DF36009BC1C7DF6207284F88F98557FFAEA327A82FE757CB7C9D79B1C2D19464F21F3C01AA77EBAF98BDAA82CCED3BB75F1B7508758024233C0B742EEE2B34D10FA0DDE57925B210A1038A7AC6E51625E62F70B576F0DA44F42652015A08A7C4D2AFC00A37588806577F11CBCC02EB83D66F006AE80F7563FE355036967044BF6E94500562988B20A06198F7E4532EC47AF3FFE1F41E5D7447A900000 , N'6.1.3-40302')

