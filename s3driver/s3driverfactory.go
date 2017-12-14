package s3driver

import (
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/s3"
	"github.com/koofr/graval"
)

type S3DriverFactory struct {
	Username      string
	Password      string
	AWSCfg        *aws.Config
	AWSRegion     string
	AWSBucketName string
}

func (f *S3DriverFactory) NewDriver() (d graval.FTPDriver, err error) {
	return &S3Driver{
		Username:      f.Username,
		Password:      f.Password,
		AWSRegion:     f.AWSRegion,
		S3:            s3.New(session.New(), f.AWSCfg),
		AWSBucketName: f.AWSBucketName,
	}, nil
}
